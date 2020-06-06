<?xml version="1.0" encoding="UTF-8"?>
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="UBL-syntax">
		
		<rule context="/ubl:Invoice">
			
			<assert test="not(cac:PaymentMeans/cac:PayerFinancialAccount)" flag="warning" id="UBL-CR-423">[UBL-CR-423]-A UBL invoice should not include the PaymentMeans PayerFinancialAccount</assert>
			
			<assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID='GST']/cbc:CompanyID) &lt;= 1)" flag="warning" id="UBL-SR-12-GST_SG">[UBL-SR-12-GST-SG]-Seller GST identifier shall occur maximum once</assert>
			<assert test="(count(cac:AccountingSupplierParty/cac:Party/cac:PartyTaxScheme[cac:TaxScheme/cbc:ID!='GST']/cbc:ID) &lt;= 1)" flag="warning" id="UBL-SR-13-GST-SG">[UBL-SR-13-GST-SG]-Seller tax registration shall occur maximum once</assert>
			
			<assert test="(count(cac:AccountingCustomerParty/cac:Party/cac:PartyTaxScheme/cbc:CompanyID) &lt;= 1)" flag="warning" id="UBL-SR-18-GST">[UBL-SR-18-GST]-Buyer GST identifier shall occur maximum once</assert>
			
		</rule>
		<rule context="cac:InvoiceLine">
			
			<assert test="(count(cac:Item/cac:ClassifiedTaxCategory/cbc:TaxExemptionReason) &lt;= 1)" flag="warning" id="UBL-SR-38-GST-SG">[UBL-SR-38-GST-SG]-Invoiced item GST exemption reason text shall occur maximum once</assert>
		</rule>
		
		
		
		<rule context="cac:TaxRepresentativeParty">
					<assert test="(count(cac:Party/cac:PartyTaxScheme/cbc:CompanyID) &lt;= 1)" flag="warning" id="UBL-SR-23-GST-SG">[UBL-SR-23-GST-SG]-Seller tax representative GST identifier shall occur maximum once, if the Seller has a tax representative</assert>
		</rule>
		<rule context="cac:TaxSubtotal">
			<assert test="(count(cac:TaxCategory/cbc:TaxExemptionReason) &lt;= 1)" flag="warning" id="UBL-SR-32-SG">[UBL-SR-32-SG]-GST exemption reason text shall occur maximum once</assert>
		</rule>
	</pattern>