# GSICS Metadata Validator

## What is This?

This repository holds [ISO Schematron](http://standards.iso.org/ittf/PubliclyAvailableStandards/c040833_ISO_IEC_19757-3_2006(E).zip) files that implement the conformance testing suite for [GSICS](http://gsics.wmo.int) [CF](http://cf-convention.github.io)-[netCDF](http://www.unidata.ucar.edu/software/netcdf/index.html) files. The tests validate both the structure and the metadata content of these files.

## Prerequisites

* Java virtual machine version 1.4 or later
* [Saxon-HE](http://saxon.sourceforge.net) for Java
* [ncdump](https://www.unidata.ucar.edu/software/netcdf/docs/netcdf/ncdump.html) utility that can produce NcML output if validating local files
* [curl](http://curl.haxx.se) utility if validating via URLs
* XSLT 2.0 implementation of the [ISO Schematron](http://www.schematron.com/implementation.html)

## Installation

No special installation is required. Two bash scripts, `sch2xslt.sh` and `validate.sh`, are independent from the run location. For their specific instructions run the scripts with the `-h` option.

## How to Use


