# GSICS Metadata Validator

## What is This?

This repository holds [ISO Schematron](http://standards.iso.org/ittf/PubliclyAvailableStandards/c040833_ISO_IEC_19757-3_2006(E).zip) files that implement the conformance testing suite for [GSICS](http://gsics.wmo.int) [CF](http://cf-convention.github.io)-[netCDF](http://www.unidata.ucar.edu/software/netcdf/index.html) files. The tests validate both the structure and the metadata content of these files.

Also included are two bash scripts: `sch2xslt.sh` and `validate.sh`. The
first script translates the Schematron files (`.sch`) into the form the
second script can utilize for validation.

## Prerequisites

* Java virtual machine version 1.4 or later
* [Saxon-HE](http://saxon.sourceforge.net) for Java
* [ncdump](https://www.unidata.ucar.edu/software/netcdf/docs/netcdf/ncdump.html)
  command-line program that can produce NcML output if validating local
  netCDF files
* [curl](http://curl.haxx.se) command-line program if validating netCDF
  files via URLs
* XSLT 2.0 implementation of the [ISO
  Schematron](http://www.schematron.com/implementation.html)

## Installation

No special installation is required beyond setting up the prerequisites and
knowing the location of the GSICS Schematron files. The two bash scripts
are independent from the run location. For their specific instructions
invoke the scripts with the `-h` option.

## How to Use

The conformance tests are implemented in a modular fashion. The
`gsics-ncml-base.sch` file contains abstract pattern definitions of almost
all the content objects expected in GSICS netCDF files: global attribute
(generic, geospatial, datetime), dimension, and variable. These abstract
patterns comprise of ISO Schematron rules that check for presence and
various metadata properties of those objects.

The `gsics-geoleoir-common.sch` file uses the abstract patterns from
`gsics-ncml-base.sch` file and implements the conformance tests for the
content required to appear in all GSICS netCDF files of one product type,
in this case the GEO-LEO-IR.

The producer-specific content is validated with the rules found in the
`gsics-nesdis-geoleoir.sch` and `gsics-jma-geoleoir.sch` files. These two
files also import all the tests from the `gsics-geoleoir-common.sch` file
so they are the only Schematron files that need to be used for complete
validation of GSICS netCDF files from particular data producer.

In order to use producer-specific Schematron files for conformance testing
they need to be translated into XSLT 2.0 statements. This is the task of
the `sch2xslt.sh` bash script. Once the Schematron rules are translated,
the `validate.sh` bash script performs the actual validation. For more
detailed information on how to use these scripts run them with the `-h`
option.


