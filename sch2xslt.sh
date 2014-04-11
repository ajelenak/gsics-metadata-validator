#!/bin/bash

HELP=$(cat <<HELP

SYNOPSIS

   $(basename $0) [-k] [-v] [-h] -j JAR-FILE -i XSLT-DIR
               -o {svrl | text} SCH-FILE

DESCRIPTION

   The $(basename $0) script takes a file with ISO Schematron validation
   rules and produces an XSLT script that can be applied to validate XML
   documents. Requirements:
   
   - Java virtual machine version 1.4 or later
   - Saxon-HE (http://saxon.sourceforge.net)
   - XSLT 2.0 implementation of the ISO Schematron
     (http://www.schematron.com/implementation.html).

   The output XSLT 2.0 file has the same name as the input Schematron file.

OPTIONS

   -k
      Keep all the intermediately produced Schematron files.

   -v
      Verbose processing. Report on actions taken.

   -j JAR-FILE
      Full path to the Saxon JAR file. Required.

   -i XSLT-DIR
      Directory with ISO Schematron XSLT scripts. Required.

   -o {svrl | text}
      Report output format. When "-o svrl" the final XSLT script will
      produce the validation report in the Schematron Validation Report
      Language (SVRL) format. With "-o text" the validation report is
      printed out as plain text in a terminal window. The default is "text".

   -h
      Print this help text.

EXIT STATUS

   The command returns 0 on success and 1 if an error occurs.

VERSION

   1.0.0

AUTHOR

   Aleksandar.Jelenak@gmail.com
HELP
)

while getopts ":kvhj:i:o:" opt; do
   case $opt in
      k)
         KEEP=1
         ;;
      v)
         VERBOSE="-v"
         ;;
      h)
         echo "$HELP"
         exit
         ;;
      j)
         if [ ! -f "$OPTARG" ]; then
            echo "'$OPTARG' is not a file" >&2
            exit 1
         fi
         JAR="$OPTARG"
         ;;
      i)
         if [ ! -d "$OPTARG" ]; then
            echo "'$OPTARG' is not a directory" >&2
            exit 1
         fi
         ISOSCH="$OPTARG"
         ;;
      o)
         $OUTPUT = "$OPTARG"
         ;;
      \?)
         echo "Unsupported option: -$OPTARG" >&2
         exit 1
         ;;
      :)
         echo "Option -$OPTARG requires an argument" >&2
         exit 1
   esac
done
shift $((OPTIND - 1))

if [ -z "$1" ]; then
   echo "Input ISO Schematron file missing" >&2
   exit 1
fi

# Saxon command
if [ -z "$JAR" ]; then
   echo "Saxon JAR file not declared" >&2
   exit 1
fi
SAXON="java -classpath $JAR net.sf.saxon.Transform -versionmsg:off"

# Schematron XSLT scripts
if [ -z "$ISOSCH" ]; then
   echo "Schematron XSLT directory not declared" >&2
   exit 1
fi
dsdl_include="$ISOSCH/iso_dsdl_include.xsl"
abstract_expand="$ISOSCH/iso_abstract_expand.xsl"
svrl="$ISOSCH/iso_svrl_for_xslt2.xsl"
text="$ISOSCH/iso_schematron_text.xsl"
if [ -z "$OUTPUT" -o "$OUTPUT" = "text" ]; then
   out=$text
elif [ "$OUTPUT" = "svrl" ]; then
   out=$svrl
else
   echo "'$OUTPUT' unsupported validation report type" >&2
   exit 1
fi
for f in $dsdl_include $abstract_expand $out; do
   if [ ! -f "$f" ]; then
      echo "$f not a file" >&2
      exit 1
   fi
done

# Schematron input file sans extension
sch_file="${1%.*}"

# Step 1: Combine schema into one
step1="$sch_file.step1.sch"
cmd="$SAXON -s:$1 -o:$step1 -xsl:$dsdl_include"
[[ -n $VERBOSE ]] && echo "$cmd"
$cmd
if [ $? -ne 0 ]; then
   echo "Combining schema from include files failed" >&2
   exit 1
fi

# Step 2: Expand abstract patterns
step2="$sch_file.step2.sch"
cmd="$SAXON -s:$step1 -o:$step2 -xsl:$abstract_expand"
[[ -n $VERBOSE ]] && echo "$cmd"
$cmd
if [ $? -ne 0 ]; then
   echo "Expanding abstract patterns failed" >&2
   exit 1
fi
if [ -z "$KEEP" ]; then
   [[ -n $VERBOSE ]] && echo -n "Removing "
   rm $VERBOSE $step1
fi

# Step 3: Create the XSLT script for validation
sch2xslt="$sch_file.xsl"
cmd="$SAXON -s:$step2 -o:$sch2xslt -xsl:$out"
[[ -n $VERBOSE ]] && echo "$cmd"
$cmd
if [ $? -ne 0 ]; then
   echo "Transforming into the final XSLT validation script failed" >&2
   exit 1
fi
if [ -z "$KEEP" ]; then
   [[ -n $VERBOSE ]] && echo -n "Removing "
   rm $VERBOSE $step2
fi

echo "$sch2xslt is ready for use"
