<?xml version="1.0" encoding="UTF-8"?>
<!--
  This schema validates GSICS GEO-LEO-IR netCDF files produced by NESDIS.
  The rules here represent the minimal valid metadata content that every
  GEO-LEO-IR file produced by NESDIS must provide.
  
  The schema depends on the gsics-geoleoir-core.sch file. Inclusion of this
  file is done using a novel feature documented in this email:
  
  http://www.stylusstudio.com/xmldev/201006/post80010.html
  
  This feature may not be supported yet by various XML editors so the best
  approach is to use the XSLT scripts from http://www.schematron.com/implementation.html
  and run the iso_dsdl_include.xsl script on this file. The resulting Schematron
  file can then be opened in an XML editor for testing.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  
  <extends href="./gsics-geoleoir-common.sch"/>
  
  <ns prefix="nc" uri="http://www.unidata.ucar.edu/namespaces/netcdf/ncml-2.2"/>
  
  <!-- 
    Validating content specific to NESDIS files.
  -->
  
  <!-- Global attributes -->
  <pattern is-a="global-attribute" id="institution">
    <param name="attrName" value="'institution'"/>
    <param name="attrValue" value="'NOAA Satellite and Information Service (NESDIS)'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="standard_name_vocabulary">
    <param name="attrName" value="'standard_name_vocabulary'"/>
    <param name="attrValue" value="'CF Standard Name Table (Version 19, 22 March 2012)'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="naming_authority">
    <param name="attrName" value="'naming_authority'"/>
    <param name="attrValue" value="'gov.noaa.nesdis.gsics'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="creator_name">
    <param name="attrName" value="'creator_name'"/>
    <param name="attrValue" value="'NOAA/NESDIS Center for Satellite Applications and Research GPRC'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="creator_email">
    <param name="attrName" value="'creator_email'"/>
    <param name="attrValue" value="'nesdis.star.gprc@noaa.gov'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="creator_url">
    <param name="attrName" value="'creator_url'"/>
    <param name="attrValue" value="'https://gsics.nesdis.noaa.gov/wiki/GPRC'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="brightness_to_radiance_conversion_formula">
    <param name="attrName" value="'brightness_to_radiance_conversion_formula'"/>
    <param name="attrValue" value="'radiance=(c1*wnc^3)/((exp(c2*wnc/(alpha*tb+beta)))-1.)'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="radiance_to_effective_conversion_formula">
    <param name="attrName" value="'radiance_to_effective_conversion_formula'"/>
    <param name="attrValue" value="'teff=((c2*wnc)/ln(1.+(c1*wnc^3)/radiance)'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern is-a="global-attribute" id="effective_to_brightness_conversion_formula">
    <param name="attrName" value="'effective_to_brightness_conversion_formula'"/>
    <param name="attrValue" value="'tb=a1+a2*teff+a3*teff^2'"/>
    <param name="attrType" value="''"/>
  </pattern>
  <pattern id="monitored_instrument">
    <rule context="/nc:netcdf">
      <assert test="nc:attribute[@name = 'monitored_instrument']">Global attribute "monitored_instrument": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:attribute[@name = 'monitored_instrument']">
      <assert test="@value = ('GOES-13 Imager', 'GOES-15 Imager')">Global attribute "<value-of select="@name"/>": Invalid value.</assert>
    </rule>
  </pattern>
  <pattern id="reference_instrument">
    <rule context="/nc:netcdf">
      <assert test="nc:attribute[@name = 'reference_instrument']">Global attribute "reference_instrument": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:attribute[@name = 'reference_instrument']">
      <assert test="@value = ('Metop-A IASI')">Global attribute "<value-of select="@name"/>": Invalid value.</assert>
    </rule>
  </pattern>
  
  <!-- Variables -->
  <pattern is-a="variable" id="slope">
    <param name="varName" value="'slope'"/>
    <param name="varShape" value="'date chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="true()"/>
  </pattern>
  <pattern is-a="variable" id="slope_se">
    <param name="varName" value="'slope_se'"/>
    <param name="varShape" value="'date chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="true()"/>
  </pattern>
  <pattern is-a="variable" id="offset">
    <param name="varName" value="'offset'"/>
    <param name="varShape" value="'date chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'mW m-2 sr-1(cm-1)-1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="true()"/>
  </pattern>
  <pattern is-a="variable" id="offset_se">
    <param name="varName" value="'offset_se'"/>
    <param name="varShape" value="'date chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'mW m-2 sr-1(cm-1)-1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="true()"/>
  </pattern>
  <pattern is-a="variable" id="covariance">
    <param name="varName" value="'covariance'"/>
    <param name="varShape" value="'date chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'mW m-2 sr-1(cm-1)-1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="true()"/>
  </pattern>
  <pattern is-a="variable" id="a1">
    <param name="varName" value="'a1'"/>
    <param name="varShape" value="'chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'K'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="()"/>
  </pattern>
  <pattern is-a="variable" id="a2">
    <param name="varName" value="'a2'"/>
    <param name="varShape" value="'chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="()"/>
  </pattern>
  <pattern is-a="variable" id="a3">
    <param name="varName" value="'a3'"/>
    <param name="varShape" value="'chan'"/>
    <param name="varType" value="'float'"/>
    <param name="varUnits" value="'1'"/>
    <param name="stdName" value="''"/>
    <param name="varMinMax" value="()"/>
  </pattern>
</schema>
