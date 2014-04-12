<?xml version="1.0" encoding="UTF-8"?>
<!--
  This schema implements the core validation rules for GSICS GEO-LEO-IR netCDF
  file metadata content. The rules here represent the minimal valid metadata
  content that every GEO-LEO-IR file must adhere to.
  
  The schema depends on the abstract patterns defined in the
  gsics-ncml-base.sch file. Inclusion of these definitions is done using
  a novel feature documented in this email:
  
  http://www.stylusstudio.com/xmldev/201006/post80010.html
  
  This feature may not be supported yet by various XML editors so the best
  approach is to use the XSLT scripts from http://www.schematron.com/implementation.html
  and run the iso_dsdl_include.xsl script. The resulting Schematron file can
  then be opened in an XML editor for testing.
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  
  <extends href="./gsics-ncml-base.sch"/>
  
  <ns prefix="nc" uri="http://www.unidata.ucar.edu/namespaces/netcdf/ncml-2.2"/>
  
  <!-- Validating global attributes -->
    <pattern id="Conventions">
      <rule context="/nc:netcdf">
        <assert test="nc:attribute[@name = 'Conventions']">Global attribute "<value-of select="'Conventions'"/>": Not found.</assert>
      </rule>
      <rule context="/nc:netcdf/nc:attribute[@name = 'Conventions']">
        <assert test="@value = ('CF-1.6', 'CF-1.5')"> Global attribute "<value-of select="@name"/>": Invalid value: "<value-of select="@value"/>". </assert>
      </rule>
    </pattern>
    <!--<pattern is-a="global-attribute" id="Conventions">
      <param name="attrName" value="'Conventions'"/>
      <param name="attrValue" value="('CF-1.6', 'CF-1.5')"/>
      <param name="attrType" value="''"/>
    </pattern>-->
    <pattern is-a="global-attribute" id="Metadata_Conventions">
      <param name="attrName" value="'Metadata_Conventions'"/>
      <param name="attrValue" value="'Unidata Dataset Discovery v1.0'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="project">
      <param name="attrName" value="'project'"/>
      <param name="attrValue" value="'Global Space-based Inter-Calibration System &lt;http://gsics.wmo.int&gt;'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="license">
      <param name="attrName" value="'license'"/>
      <param name="attrValue"
        value="'Information delivered as a GSICS product is generated in accordance with the GSICS principles and practices. GSICS products are public and may be used and redistributed freely. Any publication using GSICS products should acknowledge both GSICS and the relevant data creator organization. Neither the data creator, nor the data publisher, nor any of their employees or contractors, makes any warranty, express or implied, including warranties of merchantability and fitness for a particular purpose, or assumes any legal liability for the accuracy, completeness, or usefulness, of this information.'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="title">
      <param name="attrName" value="'title'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="summary">
      <param name="attrName" value="'summary'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="keywords">
      <param name="attrName" value="'keywords'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="references">
      <param name="attrName" value="'references'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="id">
      <param name="attrName" value="'id'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="history">
      <param name="attrName" value="'history'"/>
      <param name="attrValue" value="''"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="wmo_data_category">
      <param name="attrName" value="'wmo_data_category'"/>
      <param name="attrValue" value="30"/>
      <param name="attrType" value="'short'"/>
    </pattern>
    <pattern id="wmo_international_data_subcategory">
      <rule context="/nc:netcdf">
        <assert test="nc:attribute[@name = 'wmo_international_data_subcategory']">Global attribute "wmo_international_data_subcategory": Not found.</assert>
      </rule>
      <rule context="nc:attribute[@name = 'wmo_international_data_subcategory']">
        <assert test="@value = (4, 5)"> Global attribute "<value-of select="@name"/>": Invalid value: "<value-of select="@value"/>". </assert>
        <assert test="@type = 'short'"> Global attribute "<value-of select="@name"/>": Invalid type: "<value-of select="@type"/>". </assert>
      </rule>
    </pattern>
    <pattern is-a="global-attribute" id="local_data_subcategory">
      <param name="attrName" value="'local_data_subcategory'"/>
      <param name="attrValue" value="1"/>
      <param name="attrType" value="'short'"/>
    </pattern>
    <pattern is-a="global-attribute" id="geospatial_lat_units">
      <param name="attrName" value="'geospatial_lat_units'"/>
      <param name="attrValue" value="'degrees_north'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="geospatial_lon_units">
      <param name="attrName" value="'geospatial_lon_units'"/>
      <param name="attrValue" value="'degrees_east'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute-geospatial" id="geospatial_lat_min">
      <param name="attrName" value="'geospatial_lat_min'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValMin" value="-90"/>
      <param name="attrValMax" value="90"/>
    </pattern>
    <pattern is-a="global-attribute-geospatial" id="geospatial_lat_max">
      <param name="attrName" value="'geospatial_lat_max'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValMin" value="-90"/>
      <param name="attrValMax" value="90"/>
    </pattern>
    <pattern>
      <rule context="/nc:netcdf">
        <report test="not(nc:attribute[@name = 'geospatial_lat_max']/@value > nc:attribute[@name = 'geospatial_lat_min']/@value)">
          Global attribute "geospatial_lat_max" (<value-of select="nc:attribute[@name = 'geospatial_lat_max']/@value"/>) value must be greater than global attribute "geospatial_lat_min" (<value-of select="nc:attribute[@name = 'geospatial_lat_min']/@value"/>) value.
        </report>
      </rule>
    </pattern>
    <pattern is-a="global-attribute-geospatial" id="geospatial_lon_min">
      <param name="attrName" value="'geospatial_lon_min'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValMin" value="-180"/>
      <param name="attrValMax" value="180"/>
    </pattern>
    <pattern is-a="global-attribute-geospatial" id="geospatial_lon_max">
      <param name="attrName" value="'geospatial_lon_max'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValMin" value="-180"/>
      <param name="attrValMax" value="180"/>
    </pattern>
    <pattern is-a="global-attribute" id="planck_function_constant_c1">
      <param name="attrName" value="'planck_function_constant_c1'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValue" value="1.19104E-5"/>
    </pattern>
    <pattern is-a="global-attribute" id="planck_function_constant_c2">
      <param name="attrName" value="'planck_function_constant_c2'"/>
      <param name="attrType" value="'float'"/>
      <param name="attrValue" value="1.43877"/>
    </pattern>
    <pattern is-a="global-attribute" id="planck_function_constant_c1_unit">
      <param name="attrName" value="'planck_function_constant_c1_unit'"/>
      <param name="attrValue" value="'mW(cm^-1)^-4 m^-2 sr^-1'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern is-a="global-attribute" id="planck_function_constant_c2_unit">
      <param name="attrName" value="'planck_function_constant_c2_unit'"/>
      <param name="attrValue" value="'K cm'"/>
      <param name="attrType" value="''"/>
    </pattern>
    <pattern id="processing_level">
      <rule context="/nc:netcdf">
        <assert test="nc:attribute[@name = 'processing_level']">Global attribute "processing_level": Not found.</assert>
      </rule>
      <rule context="/nc:netcdf/nc:attribute[@name = 'processing_level']">
        <assert test="matches(@value, '^(demonstration|preoperational|operational)/v[0-9]+\.[0-9]+\.[0-9]+$')">
          Global attribute "<value-of select="@name"/>": Invalid value: "<value-of select="@value"/>".
        </assert>
      </rule>
    </pattern>
    <pattern is-a="global-attribute-datetime" id="date_created">
      <param name="attrName" value="'date_created'"/>
    </pattern>
    <pattern is-a="global-attribute-datetime" id="date_modified">
      <param name="attrName" value="'date_modified'"/>
    </pattern>
    <pattern>
      <rule context="/nc:netcdf">
        <report test="nc:attribute[@name = 'date_modified']/@value and nc:attribute[@name = 'date_created']/@value and not(nc:attribute[@name = 'date_modified']/@value >= nc:attribute[@name = 'date_created']/@value)">
          Global attribute "date_modified" value (<value-of select="nc:attribute[@name = 'date_modified']/@value"/>) must be after or same
          as global attribute "date_created" value (<value-of select="nc:attribute[@name = 'date_created']/@value"/>).
        </report>
      </rule>
    </pattern>
    <pattern is-a="global-attribute-datetime" id="time_coverage_start">
      <param name="attrName" value="'time_coverage_start'"/>
    </pattern>
    <pattern is-a="global-attribute-datetime" id="time_coverage_end">
      <param name="attrName" value="'time_coverage_end'"/>
    </pattern>
    <pattern>
      <rule context="/nc:netcdf">
        <assert test="nc:attribute[@name = 'time_coverage_end']/@value > nc:attribute[@name = 'time_coverage_start']/@value">
          Global attribute "time_coverage_end" value (<value-of select="nc:attribute[@name = 'time_coverage_end']/@value"/>) must be 
          after global attribute "time_coverage_start" value (<value-of select="nc:attribute[@name = 'time_coverage_start']/@value"/>).
        </assert>
      </rule>
    </pattern>
  
    <!-- Validating dimensions -->
    <pattern is-a="dimension" id="chan">
      <param name="dimName" value="'chan'"/>
      <param name="dimLen" value="()"/>
    </pattern>
    <pattern is-a="dimension" id="chan_strlen">
      <param name="dimName" value="'chan_strlen'"/>
      <param name="dimLen" value="()"/>
    </pattern>
    <pattern is-a="dimension" id="date_dim">
      <param name="dimName" value="'date'"/>
      <param name="dimLen" value="()"/>
    </pattern>
    <pattern is-a="dimension" id="validity">
      <param name="dimName" value="'validity'"/>
      <param name="dimLen" value="2"/>
    </pattern>
  
    <!-- Validating variables -->
    <pattern is-a="variable" id="wnc">
      <param name="varName" value="'wnc'"/>
      <param name="varShape" value="'chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'cm^-1'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="beta">
      <param name="varName" value="'beta'"/>
      <param name="varShape" value="'chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'K'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="alpha">
      <param name="varName" value="'alpha'"/>
      <param name="varShape" value="'chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'1'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="channel_name">
      <param name="varName" value="'channel_name'"/>
      <param name="varShape" value="'chan chan_strlen'"/>
      <param name="varType" value="'char'"/>
      <param name="varUnits" value="''"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="central_wavelength">
      <param name="varName" value="'central_wavelength'"/>
      <param name="varShape" value="'chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'m'"/>
      <param name="stdName" value="'radiation_wavelength'"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="date">
      <param name="varName" value="'date'"/>
      <param name="varShape" value="'date'"/>
      <param name="varType" value="'double'"/>
      <param name="varUnits" value="'seconds since 1970-01-01T00:00:00Z'"/>
      <param name="stdName" value="'time'"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="validity_period">
      <param name="varName" value="'validity_period'"/>
      <param name="varShape" value="'date validity'"/>
      <param name="varType" value="'double'"/>
      <param name="varUnits" value="'seconds since 1970-01-01T00:00:00Z'"/>
      <param name="stdName" value="'time'"/>
      <param name="varMinMax" value="()"/>
    </pattern>
    <pattern is-a="variable" id="std_scene_tb">
      <param name="varName" value="'std_scene_tb'"/>
      <param name="varShape" value="'chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'K'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="true()"/>
    </pattern>
    <pattern is-a="variable" id="std_scene_tb_bias">
      <param name="varName" value="'std_scene_tb_bias'"/>
      <param name="varShape" value="'date chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'K'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="true()"/>
    </pattern>
    <pattern is-a="variable" id="std_scene_tb_bias_se">
      <param name="varName" value="'std_scene_tb_bias_se'"/>
      <param name="varShape" value="'date chan'"/>
      <param name="varType" value="'float'"/>
      <param name="varUnits" value="'K'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="true()"/>
    </pattern>
    <pattern is-a="variable" id="number_of_collocations">
      <param name="varName" value="'number_of_collocations'"/>
      <param name="varShape" value="'date chan'"/>
      <param name="varType" value="'int'"/>
      <param name="varUnits" value="'1'"/>
      <param name="stdName" value="''"/>
      <param name="varMinMax" value="true()"/>
    </pattern>
</schema>
