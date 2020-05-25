<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"	version="3.0" xmlns:sh="http://purl.oclc.org/dsdl/schematron" xmlns:ex="http://validex.net/schematron/exclusion-filter" >
<xsl:output method="xml"/>
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="/sh:schema/sh:pattern/sh:rule/sh:assert[document('ExcludedRulesList_PEPPOL.xml')/ex:ExcludedRules/ex:RuleID = @id]">
      <xsl:comment>Rule excluded:<xsl:value-of select="./@id" /> </xsl:comment>
  </xsl:template>
  

</xsl:stylesheet>