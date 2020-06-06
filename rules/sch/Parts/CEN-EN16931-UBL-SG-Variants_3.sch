<?xml version="1.0" encoding="UTF-8"?>
	<!--Suppressed abstract pattern model was here-->
	<!--Suppressed abstract pattern syntax was here-->
	<!--Start pattern based on abstract model-->
	
	<!--Start pattern based on abstract syntax-->

	<pattern id="Codesmodel">
		<!-- 2019-06-12/MF - Added newest ICD values manually -->
		
		<rule context="cac:TaxCategory/cbc:ID" flag="fatal">
			<assert test="( ( not(contains(normalize-space(.),' ')) and contains( ' SR SRCA-S SRCA-C ZR ES33 ESN33 DS OS NG ',concat(' ',normalize-space(.),' ') ) ) )" id="BR-CL-17-GST-SG" flag="fatal">[BR-CL-17-GST-SG]-Invoice tax categories MUST be coded using valid Singapore code values</assert>
		</rule>
		<rule context="cac:ClassifiedTaxCategory/cbc:ID" flag="fatal">
			<assert test="( ( not(contains(normalize-space(.),' ')) and contains( ' SR SRCA-S SRCA-C ZR ES33 ESN33 DS OS NG ',concat(' ',normalize-space(.),' ') ) ) )" id="BR-CL-18-GST-SG" flag="fatal">[BR-CL-18-GST-SG]-Invoice tax categories MUST be coded using valid Singapore code values</assert>
		</rule>
		
		
	</pattern>

