<?xml version="1.0" encoding="UTF-8"?>
	<!--
    Transaction rules

    R00X - Document level
    R01X - Accounting customer
    R02X - Accounting supplier
    R04X - Allowance/Charge (document and line)
    R05X - Tax
    R06X - Payment
    R08X - Additonal document reference
    R1XX - Line level
    R11X - Invoice period
  -->
	<pattern xmlns="http://purl.oclc.org/dsdl/schematron">
		<!-- Document level -->
		<rule context="ubl-creditnote:CreditNote | ubl-invoice:Invoice">
			<assert id="PEPPOL-EN16931-R001" test="cbc:ProfileID" flag="fatal">Business process MUST be provided.</assert>
			<!--Rule excluded:PEPPOL-EN16931-R007-->
			<assert id="PEPPOL-EN16931-R002" test="count(cbc:Note) &lt;= 1" flag="fatal">No more than one note is allowed on document level.</assert>
			<assert id="PEPPOL-EN16931-R003" test="cbc:BuyerReference or cac:OrderReference/cbc:ID" flag="fatal">A buyer reference or purchase order reference MUST be provided.</assert>
			<!--Rule excluded:PEPPOL-EN16931-R004-->
			<assert id="PEPPOL-EN16931-R053" test="count(cac:TaxTotal[cac:TaxSubtotal]) = 1" flag="fatal">Only one tax total with tax subtotals MUST be provided.</assert>
			<assert id="PEPPOL-EN16931-R054" test="count(cac:TaxTotal[not(cac:TaxSubtotal)]) = (if (cbc:TaxCurrencyCode) then 1 else 0)" flag="fatal">Only one tax total without tax subtotals MUST be provided when tax currency code is provided.</assert>
			<!--Rule excluded:PEPPOL-EN16931-R055-->
			<assert id="PEPPOL-EN16931-R006" test="(count(cac:AdditionalDocumentReference[cbc:DocumentTypeCode='130']) &lt;= 1)" flag="fatal">Only one invoiced object is allowed on document level</assert>
			<assert id="PEPPOL-EN16931-R080" test="(count(cac:AdditionalDocumentReference[cbc:DocumentTypeCode='50']) &lt;= 1)" flag="fatal">Only one project reference is allowed on document level</assert>
		</rule>
		<rule context="cbc:TaxCurrencyCode">
			<assert id="PEPPOL-EN16931-R005" test="not(normalize-space(text()) = normalize-space(../cbc:DocumentCurrencyCode/text()))" flag="fatal">VAT accounting currency code MUST be different from invoice currency code when provided.</assert>
		</rule>
		<!-- Accounting customer -->
		<rule context="cac:AccountingCustomerParty/cac:Party">
			<assert id="PEPPOL-EN16931-R010" test="cbc:EndpointID" flag="fatal">Buyer electronic address MUST be provided</assert>
		</rule>
		<!-- Accounting supplier -->
		<rule context="cac:AccountingSupplierParty/cac:Party">
			<assert id="PEPPOL-EN16931-R020" test="cbc:EndpointID" flag="fatal">Seller electronic address MUST be provided</assert>
		</rule>
		<!-- Allowance/Charge (document level/line level) -->
		<rule context="ubl-invoice:Invoice/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[cbc:MultiplierFactorNumeric and not(cbc:BaseAmount)]">
			<assert id="PEPPOL-EN16931-R041" test="false()" flag="fatal">Allowance/charge base amount MUST be provided when allowance/charge percentage is provided.</assert>
		</rule>
		<rule context="ubl-invoice:Invoice/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount] | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge[not(cbc:MultiplierFactorNumeric) and cbc:BaseAmount]">
			<assert id="PEPPOL-EN16931-R042" test="false()" flag="fatal">Allowance/charge percentage MUST be provided when allowance/charge base amount is provided.</assert>
		</rule>
		<rule context="ubl-invoice:Invoice/cac:AllowanceCharge | ubl-invoice:Invoice/cac:InvoiceLine/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:AllowanceCharge | ubl-creditnote:CreditNote/cac:CreditNoteLine/cac:AllowanceCharge">
			<assert id="PEPPOL-EN16931-R040" test="           not(cbc:MultiplierFactorNumeric and cbc:BaseAmount) or u:slack(if (cbc:Amount) then             cbc:Amount           else             0, (xs:decimal(cbc:BaseAmount) * xs:decimal(cbc:MultiplierFactorNumeric)) div 100, 0.02)" flag="fatal">Allowance/charge amount must equal base amount * percentage/100 if base amount and percentage exists</assert>
			<!--Rule excluded:PEPPOL-EN16931-R043-->
		</rule>
		<!-- Payment -->
		<rule context="         cac:PaymentMeans[some $code in tokenize('49 59', '\s')           satisfies normalize-space(cbc:PaymentMeansCode) = $code]">
			<assert id="PEPPOL-EN16931-R061" test="cac:PaymentMandate/cbc:ID" flag="fatal">Mandate reference MUST be provided for direct debit.</assert>
		</rule>
		<!-- Currency -->
		<rule context="cbc:Amount | cbc:BaseAmount | cbc:PriceAmount | cac:TaxTotal[cac:TaxSubtotal]/cbc:TaxAmount | cbc:TaxableAmount | cbc:LineExtensionAmount | cbc:TaxExclusiveAmount | cbc:TaxInclusiveAmount | cbc:AllowanceTotalAmount | cbc:ChargeTotalAmount | cbc:PrepaidAmount | cbc:PayableRoundingAmount | cbc:PayableAmount">
			<assert id="PEPPOL-EN16931-R051" test="@currencyID = $documentCurrencyCode" flag="fatal">All currencyID attributes must have the same value as the invoice currency code (BT-5), except for the invoice total VAT amount in accounting currency (BT-111).</assert>
		</rule>
		<!-- Line level - invoice period -->
		<rule context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:StartDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:StartDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:StartDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:StartDate">
			<assert id="PEPPOL-EN16931-R110" test="xs:date(text()) &gt;= xs:date(../../../cac:InvoicePeriod/cbc:StartDate)" flag="fatal">Start date of line period MUST be within invoice period.</assert>
		</rule>
		<rule context="ubl-invoice:Invoice[cac:InvoicePeriod/cbc:EndDate]/cac:InvoiceLine/cac:InvoicePeriod/cbc:EndDate | ubl-creditnote:CreditNote[cac:InvoicePeriod/cbc:EndDate]/cac:CreditNoteLine/cac:InvoicePeriod/cbc:EndDate">
			<assert id="PEPPOL-EN16931-R111" test="xs:date(text()) &lt;= xs:date(../../../cac:InvoicePeriod/cbc:EndDate)" flag="fatal">End date of line period MUST be within invoice period.</assert>
		</rule>
		<!-- Line level - line extension amount -->
		<rule context="cac:InvoiceLine | cac:CreditNoteLine">
			<let name="lineExtensionAmount" value="           if (cbc:LineExtensionAmount) then             xs:decimal(cbc:LineExtensionAmount)           else             0"/>
			<let name="quantity" value="           if (/ubl-invoice:Invoice) then             (if (cbc:InvoicedQuantity) then               xs:decimal(cbc:InvoicedQuantity)             else               1)           else             (if (cbc:CreditedQuantity) then               xs:decimal(cbc:CreditedQuantity)             else               1)"/>
			<let name="priceAmount" value="           if (cac:Price/cbc:PriceAmount) then             xs:decimal(cac:Price/cbc:PriceAmount)           else             0"/>
			<let name="baseQuantity" value="           if (cac:Price/cbc:BaseQuantity and xs:decimal(cac:Price/cbc:BaseQuantity) != 0) then             xs:decimal(cac:Price/cbc:BaseQuantity)           else             1"/>
			<let name="allowancesTotal" value="           if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']) then             round(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'false']/cbc:Amount/xs:decimal(.)) * 10 * 10) div 100           else             0"/>
			<let name="chargesTotal" value="           if (cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']) then             round(sum(cac:AllowanceCharge[normalize-space(cbc:ChargeIndicator) = 'true']/cbc:Amount/xs:decimal(.)) * 10 * 10) div 100           else             0"/>
			<assert id="PEPPOL-EN16931-R120" test="u:slack($lineExtensionAmount, ($quantity * ($priceAmount div $baseQuantity)) + $chargesTotal - $allowancesTotal, 0.02)" flag="fatal">Invoice line net amount MUST equal (Invoiced quantity * (Item net price/item price base quantity) + Sum of invoice line charge amount - sum of invoice line allowance amount</assert>
			<assert id="PEPPOL-EN16931-R121" test="not(cac:Price/cbc:BaseQuantity) or xs:decimal(cac:Price/cbc:BaseQuantity) &gt; 0" flag="fatal">Base quantity MUST be a positive number above zero.</assert>
			<assert id="PEPPOL-EN16931-R100" test="(count(cac:DocumentReference) &lt;= 1)" flag="fatal">Only one invoiced object is allowed pr line</assert>
			<assert id="PEPPOL-EN16931-R101" test="(not(cac:DocumentReference) or (cac:DocumentReference/cbc:DocumentTypeCode='130'))" flag="fatal">Element Document reference can only be used for Invoice line object</assert>
		</rule>
		<!-- Allowance (price level) -->
		<rule context="cac:Price/cac:AllowanceCharge">
			<assert id="PEPPOL-EN16931-R044" test="normalize-space(cbc:ChargeIndicator) = 'false'" flag="fatal">Charge on price level is NOT allowed.</assert>
			<assert id="PEPPOL-EN16931-R046" test="not(cbc:BaseAmount) or xs:decimal(../cbc:PriceAmount) = xs:decimal(cbc:BaseAmount) - xs:decimal(cbc:Amount)" flag="fatal">Item net price MUST equal (Gross price - Allowance amount) when gross price is provided.</assert>
		</rule>
		<!-- Price -->
		<rule context="cac:Price/cbc:BaseQuantity[@unitCode]">
			<let name="hasQuantity" value="../../cbc:InvoicedQuantity or ../../cbc:CreditedQuantity"/>
			<let name="quantity" value="           if (/ubl-invoice:Invoice) then             ../../cbc:InvoicedQuantity           else             ../../cbc:CreditedQuantity"/>
			<assert id="PEPPOL-EN16931-R130" test="not($hasQuantity) or @unitCode = $quantity/@unitCode" flag="fatal">Unit code of price base quantity MUST be same as invoiced quantity.</assert>
		</rule>
		<!-- Validation of ICD -->

	</pattern>