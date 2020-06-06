<?xml version="1.0" encoding="UTF-8"?>
	<!-- Empty elements -->
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron">
		<rule context="//*[not(*) and not(normalize-space())]">
			<assert id="PEPPOL-EN16931-R008" test="false()" flag="fatal">Document MUST not contain empty elements.</assert>
		</rule> 
	</pattern>