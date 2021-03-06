<?xml version="1.0" encoding="US-ASCII"?>
<stylesheet 
   version="1.0"
   xmlns:exslt-dyn="http://exslt.org/dynamic"
   xmlns:map="http://example.org/ns/map"
   xmlns:ann="https://github.com/webb/schematron-cli/ns/svrl-annotation"
   xmlns:svrl="http://purl.oclc.org/dsdl/svrl"
   xmlns:xalan-nodeinfo="org.apache.xalan.lib.NodeInfo"
   xmlns="http://www.w3.org/1999/XSL/Transform">

  <output method="xml" version="1.0" indent="no"/>

  <template match="@*|node()" priority="-1">
    <copy>
      <apply-templates select="@*|node()"/>
    </copy>
  </template>

  <template match="*">
    <copy>
      <if test="@location">
        <call-template name="put-line-number"/>
      </if>
      <apply-templates select="@*|node()"/>
    </copy>
  </template>

  <template name="put-line-number">
    <variable name="location-string" select="@location"/>
    <variable name="active-pattern" select="preceding-sibling::svrl:active-pattern[1]"/>
    <variable name="document-file-name" select="$active-pattern/@document"/>
    <attribute name="ann:line-number">
      <for-each select="document($document-file-name)">
        <value-of select="xalan-nodeinfo:lineNumber( exslt-dyn:evaluate( $location-string ) )"/>
      </for-each>
    </attribute>
  </template>

</stylesheet>
