#!/bin/bash

HELP=$(cat <<HELP

SYNOPSIS

   $(basename $0) [-h] -j JAR-FILE -s STYLESHEET { NETCDF-FILE | NCML-URL }

DESCRIPTION

   The $(basename $0) script validates metadata content of a netCDF file
   using an XSLT stylesheet file which contains transformed ISO Schematron
   rules. The netCDF file can either be a local file or a URL with NcML
   response. Requirements:

   - Java virtual machine version 1.4 or later
   - Saxon-HE for Java (http://saxon.sourceforge.net)
   - ncdump utility that can produce NcML output if validating local files
   - curl utility if validating via URLs

   Any validation error is printed to stderr.

OPTIONS

   -j JAR-FILE
      Full path to the Saxon JAR file. Required.

   -s STYLESHEET
      XSLT validation script. Required.

   -h
      Print this help text.

EXIT STATUS

   The command returns 0 on success and 1 if there are validation errors.

VERSION

   1.0.0

AUTHOR

   Aleksandar.Jelenak@gmail.com
HELP
)

while getopts ":hj:s:" opt; do
   case $opt in
      j)
         if [ ! -f "$OPTARG" ]; then
            echo "'$OPTARG' is not a file" >&2
            exit 1
         fi
         JAR="$OPTARG"
         ;;
      s)
         XSLT="$OPTARG"
         if [ ! -f "$OPTARG" ]; then
            echo "'$OPTARG' is not a file" >&2
            exit 1
         fi
         ;;
      h)
         echo "$HELP"
         exit
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

if [ -z "$XSLT" -o ! -f "$XSLT" ]; then
   echo "Validating XSLT script not given or not a file" >&2
   exit 1
fi
if [ -z "$1" ]; then
   echo "What is the netCDF file to validate?" >&2
   exit 1
fi

# Based on the input netCDF file check if the right utility is available...
if [ -n "$(echo "$1" | grep '^http://')" ]; then
   if [ ! type "curl" &> /dev/null ]; then
      echo "curl not found" >&2
      exit 1
   fi
   ncml_cmd="curl -s "$1""
else
   if [ ! type "ncdump" &> /dev/null ]; then
      echo "ncdump not found" >&2
      exit 1
   fi
   if [ -z "$(ncdump 2>&1 | grep -E -e '-x.+NcML')" ]; then
      echo "ncdump does not support NcML output" >&2
      exit 1
   fi
   ncml_cmd="ncdump -xh $1"
fi

# Figure out the SAXON command...
if [ -z "$JAR" ]; then
   echo "Saxon JAR file not declared" >&2
   exit 1
fi
saxon="java -classpath $JAR net.sf.saxon.Transform -versionmsg:off"

# Validate, capture, and clean up the output...
temp_ncml=$(mktemp -q -t temp.ncml)
if [ $? -ne 0 ]; then
   echo "Failed to create a temp NcML file" >&2
   exit 1
fi
trap "rm -f $temp_ncml" EXIT
$ncml_cmd > $temp_ncml
if [ $? -ne 0 ]; then
   echo "Failed to generate NcML" >&2
   exit 1
fi
errors=$($saxon -s:$temp_ncml -xsl:$XSLT | sed -e '/^[ ]*$/ d' -e 's/^[ ]*//')
if [ -n "$errors" ]; then
   num_errors=$(echo "$errors" | wc -l);
   echo "There are $num_errors error(s):" >&2
   echo "$errors" >&2
   exit 1
fi
