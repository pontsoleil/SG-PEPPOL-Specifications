<?xml version="1.0" encoding="UTF-8"?>
  <!-- Empty elements -->
  <pattern xmlns="http://purl.oclc.org/dsdl/schematron">
    <rule context="cac:*">
      <assert id="PEPPOL-EN16931-R009" test="count(*) != 0" flag="fatal">Document MUST not contain
        empty elements.</assert>
    </rule>
  </pattern>