<?xml version="1.0" encoding="UTF-8"?>
<pattern xmlns="http://purl.oclc.org/dsdl/schematron">

    <!-- Document level -->
    <rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
     
      <assert id="PEPPOL-EN16931-R004-SG"
        test="starts-with(normalize-space(cbc:CustomizationID/text()), 'urn:cen.eu:en16931:2017#conformant#urn:fdc:peppol.eu:2017:poacc:billing:international:sg:3.0')"
        flag="fatal">Specification identifier MUST have the value 'urn:cen.eu:en16931:2017#conformant#urn:fdc:peppol.eu:2017:poacc:billing:international:sg:3.0'.</assert>

    </rule>
</pattern>