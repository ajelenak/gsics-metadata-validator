# GSICS Metadata Validator

## Prerequisites

* Java virtual machine version 1.4 or later
* [Saxon-HE](http://saxon.sourceforge.net) for Java
* [ncdump](https://www.unidata.ucar.edu/software/netcdf/docs/netcdf/ncdump.html) utility that can produce NcML output if validating local files
* [curl](http://curl.haxx.se) utility if validating via URLs
* XSLT 2.0 implementation of the [ISO Schematron](http://www.schematron.com/implementation.html)

## Installation

No special installation is required. Two bash scripts, `sch2xslt.sh` and `validate.sh`, are independent from the run location.
