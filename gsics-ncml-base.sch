<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <ns prefix="nc" uri="http://www.unidata.ucar.edu/namespaces/netcdf/ncml-2.2"/>
  <!-- 
    Definition of abstract patterns
  -->

  <!-- Abstract pattern for generic general attributes -->
  <pattern abstract="true" id="global-attribute">
    <rule context="/nc:netcdf">
      <assert test="nc:attribute[@name = $attrName]">Global attribute "<value-of select="$attrName"/>": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:attribute[@name = $attrName]">
      <report test="$attrValue and (@value != $attrValue)">Global attribute "<value-of select="@name"/>": Invalid value.</report>
      <report test="$attrType and not(@type)">
        Global attribute "<value-of select="@name"/>": Missing type declaration, expected type "<value-of select="$attrType"/>".
      </report>
      <report test="$attrType and @type and (@type != $attrType)">
        Global attribute "<value-of select="@name"/>": Invalid type: "<value-of select="@type"/>". Valid type is <value-of select="$attrType"/>.
      </report>
    </rule>
  </pattern>
  
  <!-- Abstract pattern for geospatial global attributes -->
  <pattern abstract="true" id="global-attribute-geospatial">
    <rule context="/nc:netcdf">
      <assert test="nc:attribute[@name = $attrName]">Global attribute "<value-of select="$attrName"/>": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:attribute[@name = $attrName]">
      <report test="$attrType and not(@type)">
        Global attribute "<value-of select="@name"/>": Missing type declaration, expected type "<value-of select="$attrType"/>".
      </report>
      <report test="$attrType and @type and (@type != $attrType)">
        Global attribute "<value-of select="@name"/>": Invalid type: "<value-of select="@type"/>". Valid type is "<value-of select="$attrType"/>".
      </report>
      <assert test="(xs:double(@value) >= xs:double($attrValMin)) and (xs:double(@value) &lt;= xs:double($attrValMax))">
        Global attribute "<value-of select="@name"/>": Value "<value-of select="@value"/>" outside of the valid range [<value-of select="$attrValMin"/>, <value-of select="$attrValMax"/>].
      </assert>
    </rule>
  </pattern>
  
  <!-- Abstract pattern for ISO 8601 datetime global attributes -->
  <pattern abstract="true" id="global-attribute-datetime">
    <rule context="/nc:netcdf">
      <assert test="nc:attribute[@name = $attrName]">Global attribute "<value-of select="$attrName"/>": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:attribute[@name = $attrName]">
      <assert test="@value castable as xs:dateTime">
        Global attribute "<value-of select="@name"/>": Not a valid ISO 8601 datetime: "<value-of select="@value"/>"
      </assert>
    </rule>
  </pattern>
  
  <!-- Abstract pattern for dimensions -->
  <pattern abstract="true" id="dimension">
    <rule context="/nc:netcdf">
      <assert test="nc:dimension[@name = $dimName]">Dimension "<value-of select="$dimName"/>": Not found.</assert>
    </rule>
    <rule context="/nc:netcdf/nc:dimension[@name = $dimName]">
      <report test="$dimLen and (@length != $dimLen)">
        Dimension "<value-of select="@name"/>": Wrong length "<value-of select="@length"/>", should be "<value-of select="$dimLen"/>".
      </report>
    </rule>
  </pattern>
  
  <!-- Abstract pattern for variables -->
  <pattern abstract="true" id="variable">
    <rule context="/nc:netcdf">
      <assert test="nc:variable[@name = $varName]">Variable "<value-of select="$varName"/>": Not found.</assert>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]">
      <assert test="@shape = $varShape">
        Variable "<value-of select="@name"/>": Wrong shape: "(<value-of select="replace(@shape, ' ', ', ')"/>)". Should be "(<value-of select="replace($varShape, ' ', ', ')"/>)".
      </assert>
      <assert test="@type = $varType">
        Variable "<value-of select="@name"/>": Wrong type: "<value-of select="@type"/>". Should be "<value-of select="$varType"/>".
      </assert>
      <assert test="nc:attribute[@name = 'long_name']">Variable "<value-of select="@name"/>": Attribute "long_name" missing.</assert>
      <assert test="not(nc:attribute[@name = 'bounds'])">Variable "<value-of select="@name"/>": Use of attribute "bounds" is deprecated.</assert>
      <report test="($varType != 'char') and $varUnits and not(nc:attribute[@name = 'units'])">Variable "<value-of select="@name"/>": Attribute "units" missing.</report>
      <report test="$stdName and not(nc:attribute[@name = 'standard_name'])">Variable "<value-of select="@name"/>": Attribute "standard_name" missing.</report>
      <report test="$varMinMax and not(nc:attribute[@name = 'valid_min'])">Variable "<value-of select="@name"/>": Attribute "valid_min" missing.</report>
      <report test="$varMinMax and not(nc:attribute[@name = 'valid_max'])">Variable "<value-of select="@name"/>": Attribute "valid_max" missing.</report>
      <report test="$varMinMax and nc:attribute[@name = 'valid_min'] and nc:attribute[@name = 'valid_max']
        and (xs:double(nc:attribute[@name = 'valid_min']/@value) >= xs:double(nc:attribute[@name = 'valid_max']/@value))">
        Variable "<value-of select="@name"/>": Attribute "valid_max" value (<value-of select="nc:attribute[@name = 'valid_max']/@value"/>) must be greater than attribute "valid_min" value (<value-of select="nc:attribute[@name = 'valid_min']/@value"/>).
      </report>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]/nc:attribute[@name = 'units']">
      <assert test="$varType != 'char'">Variable "<value-of select="../@name"/>": Attribute "units" is not for char type variables.</assert>
      <report test="($varType != 'char') and (@value != $varUnits)"> Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Invalid value: "<value-of select="@value"/>". </report>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]/nc:attribute[@name = 'standard_name']">
      <assert test="$stdName = @value">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Wrong value: "<value-of select="@value"/>". Should be "<value-of select="$stdName"/>".
      </assert>
      <report test="($stdName = 'time') and not(../nc:attribute[@name = 'calendar'])">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Must exist attribute "calendar" with value "gregorian". 
      </report>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]/nc:attribute[@name = 'calendar']">
      <assert test="@value = 'gregorian'">Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Only allowed value is "gregorian".</assert>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]/nc:attribute[@name = 'valid_min']">
      <assert test="../nc:attribute[@name = 'valid_max']">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Requires "valid_max" attribute.
      </assert>
      <assert test="@type = $varType">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Wrong type: "<value-of select="@type"/>". Should be "<value-of select="$varType"/>".
      </assert>
    </rule>
    
    <rule context="/nc:netcdf/nc:variable[@name = $varName]/nc:attribute[@name = 'valid_max']">
      <assert test="../nc:attribute[@name = 'valid_min']">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Requires "valid_min" attribute.
      </assert>
      <assert test="@type = $varType">
        Variable "<value-of select="../@name"/>": Attribute "<value-of select="@name"/>": Wrong type: "<value-of select="@type"/>". Should be "<value-of select="$varType"/>".
      </assert>
    </rule>
  </pattern>
  <!-- 
      End of abstract pattern defintions
  -->
</schema>