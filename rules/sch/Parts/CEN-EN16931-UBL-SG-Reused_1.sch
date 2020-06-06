<?xml version="1.0" encoding="UTF-8"?>
<pattern id="UBL-model">
    <rule context="cac:AdditionalDocumentReference">
      <assert id="BR-52" flag="fatal" test="(cbc:ID) != ''">[BR-52]-Each Additional supporting document (BG-24) shall contain a Supporting document reference (BT-122).    </assert>
    </rule>
    <rule context="/ubl:Invoice/cac:LegalMonetaryTotal/cbc:PayableAmount">
      <assert id="BR-CO-25" flag="fatal" test="((. &gt; 0) and (exists(//cbc:DueDate) or exists(//cac:PaymentTerms/cbc:Note))) or (. &lt;= 0)">[BR-CO-25]-In case the Amount due for payment (BT-115) is positive, either the Payment due date (BT-9) or the Payment terms (BT-20) shall be present.</assert>
    </rule>
    <rule context="cac:AccountingCustomerParty/cac:Party/cbc:EndpointID">
      <assert id="BR-63" flag="fatal" test="exists(@schemeID)">[BR-63]-The Buyer electronic address (BT-49) shall have a Scheme identifier.    </assert>
    </rule>
    <rule context="cac:AccountingCustomerParty/cac:Party/cac:PostalAddress">
      <assert id="BR-11" flag="fatal" test="(cac:Country/cbc:IdentificationCode) != ''">[BR-11]-The Buyer postal address shall contain a Buyer country code (BT-55).</assert>
    </rule>
    <rule context="cac:PaymentMeans/cac:CardAccount">
      <assert id="BR-51" flag="fatal" test="string-length(cbc:PrimaryAccountNumberID)&gt;=4 and string-length(cbc:PrimaryAccountNumberID)&lt;=6">[BR-51]-The last 4 to 6 digits of the Payment card primary account number (BT-87) shall be present if Payment card information (BG-18) is provided in the Invoice.</assert>
    </rule>
    <rule context="cac:Delivery/cac:DeliveryLocation/cac:Address">
      <assert id="BR-57" flag="fatal" test="exists(cac:Country/cbc:IdentificationCode)">[BR-57]-Each Deliver to address (BG-15) shall contain a Deliver to country code (BT-80).</assert>
    </rule>
    <rule context="/ubl:Invoice/cac:AllowanceCharge[cbc:ChargeIndicator = false()] | /cn:CreditNote/cac:AllowanceCharge[cbc:ChargeIndicator = false()]">
      <assert id="BR-31" flag="fatal" test="exists(cbc:Amount)">[BR-31]-Each Document level allowance (BG-20) shall have a Document level allowance amount (BT-92).</assert>
      <!--Rule excluded:BR-32-->
      <assert id="BR-33" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-33]-Each Document level allowance (BG-20) shall have a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98).</assert>
      <assert id="BR-CO-05" flag="fatal" test="true()">[BR-CO-05]-Document level allowance reason code (BT-98) and Document level allowance reason (BT-97) shall indicate the same type of allowance.</assert>
      <assert id="BR-CO-21" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-CO-21]-Each Document level allowance (BG-20) shall contain a Document level allowance reason (BT-97) or a Document level allowance reason code (BT-98), or both.</assert>
      <assert id="BR-DEC-01" flag="fatal" test="string-length(substring-after(cbc:Amount,'.'))&lt;=2">[BR-DEC-01]-The allowed maximum number of decimals for the Document level allowance amount (BT-92) is 2.</assert>
      <assert id="BR-DEC-02" flag="fatal" test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2">[BR-DEC-02]-The allowed maximum number of decimals for the Document level allowance base amount (BT-93) is 2.    </assert>
    </rule>
    <rule context="/ubl:Invoice/cac:AllowanceCharge[cbc:ChargeIndicator = true()] | /cn:CreditNote/cac:AllowanceCharge[cbc:ChargeIndicator = true()]">
      <assert id="BR-36" flag="fatal" test="exists(cbc:Amount)">[BR-36]-Each Document level charge (BG-21) shall have a Document level charge amount (BT-99).</assert>
      <!--Rule excluded:BR-37-->
      <assert id="BR-38" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-38]-Each Document level charge (BG-21) shall have a Document level charge reason (BT-104) or a Document level charge reason code (BT-105).    </assert>
      <assert id="BR-CO-06" flag="fatal" test="true()">[BR-CO-06]-Document level charge reason code (BT-105) and Document level charge reason (BT-104) shall indicate the same type of charge.</assert>
      <assert id="BR-CO-22" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-CO-22]-Each Document level charge (BG-21) shall contain a Document level charge reason (BT-104) or a Document level charge reason code (BT-105), or both.</assert>
      <assert id="BR-DEC-05" flag="fatal" test="string-length(substring-after(cbc:Amount,'.'))&lt;=2">[BR-DEC-05]-The allowed maximum number of decimals for the Document level charge amount (BT-99) is 2.</assert>
      <assert id="BR-DEC-06" flag="fatal" test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2">[BR-DEC-06]-The allowed maximum number of decimals for the Document level charge base amount (BT-100) is 2.    </assert>
    </rule>
    <rule context="cac:LegalMonetaryTotal">
      <assert id="BR-12" flag="fatal" test="exists(cbc:LineExtensionAmount)">[BR-12]-An Invoice shall have the Sum of Invoice line net amount (BT-106).</assert>
      <!--Rule excluded:BR-13-->
      <!--Rule excluded:BR-14-->
      <assert id="BR-15" flag="fatal" test="exists(cbc:PayableAmount)">[BR-15]-An Invoice shall have the Amount due for payment (BT-115).</assert>
      <assert id="BR-CO-10" flag="fatal" test="(xs:decimal(cbc:LineExtensionAmount) = (round(sum(//(cac:InvoiceLine|cac:CreditNoteLine)/xs:decimal(cbc:LineExtensionAmount)) * 10 * 10) div 100))">[BR-CO-10]-Sum of Invoice line net amount (BT-106) = Σ Invoice line net amount (BT-131).</assert>
      <assert id="BR-CO-11" flag="fatal" test="xs:decimal(cbc:AllowanceTotalAmount) = (round(sum(../cac:AllowanceCharge[cbc:ChargeIndicator=false()]/xs:decimal(cbc:Amount)) * 10 * 10) div 100) or  (not(cbc:AllowanceTotalAmount) and not(../cac:AllowanceCharge[cbc:ChargeIndicator=false()]))">[BR-CO-11]-Sum of allowances on document level (BT-107) = Σ Document level allowance amount (BT-92).</assert>
      <assert id="BR-CO-12" flag="fatal" test="xs:decimal(cbc:ChargeTotalAmount) = (round(sum(../cac:AllowanceCharge[cbc:ChargeIndicator=true()]/xs:decimal(cbc:Amount)) * 10 * 10) div 100) or (not(cbc:ChargeTotalAmount) and not(../cac:AllowanceCharge[cbc:ChargeIndicator=true()]))">[BR-CO-12]-Sum of charges on document level (BT-108) = Σ Document level charge amount (BT-99).</assert>
      <!--Rule excluded:BR-CO-13-->
      <!--Rule excluded:BR-CO-16-->
      <assert id="BR-DEC-09" flag="fatal" test="string-length(substring-after(cbc:LineExtensionAmount,'.'))&lt;=2">[BR-DEC-09]-The allowed maximum number of decimals for the Sum of Invoice line net amount (BT-106) is 2.</assert>
      <assert id="BR-DEC-10" flag="fatal" test="string-length(substring-after(cbc:AllowanceTotalAmount,'.'))&lt;=2">[BR-DEC-10]-The allowed maximum number of decimals for the Sum of allowanced on document level (BT-107) is 2.</assert>
      <assert id="BR-DEC-11" flag="fatal" test="string-length(substring-after(cbc:ChargeTotalAmount,'.'))&lt;=2">[BR-DEC-11]-The allowed maximum number of decimals for the Sum of charges on document level (BT-108) is 2.</assert>
      <!--Rule excluded:BR-DEC-12-->
      <!--Rule excluded:BR-DEC-14-->
      <assert id="BR-DEC-16" flag="fatal" test="string-length(substring-after(cbc:PrepaidAmount,'.'))&lt;=2">[BR-DEC-16]-The allowed maximum number of decimals for the Paid amount (BT-113) is 2.</assert>
      <assert id="BR-DEC-17" flag="fatal" test="string-length(substring-after(cbc:PayableRoundingAmount,'.'))&lt;=2">[BR-DEC-17]-The allowed maximum number of decimals for the Rounding amount (BT-114) is 2.</assert>
      <assert id="BR-DEC-18" flag="fatal" test="string-length(substring-after(cbc:PayableAmount,'.'))&lt;=2">[BR-DEC-18]-The allowed maximum number of decimals for the Amount due for payment (BT-115) is 2.  </assert>
    </rule>
    <rule context="/ubl:Invoice | /cn:CreditNote">
      <assert id="BR-01" flag="fatal" test="(cbc:CustomizationID) != ''">[BR-01]-An Invoice shall have a Specification identifier (BT-24).   </assert>
      <assert id="BR-02" flag="fatal" test="(cbc:ID) !=''">[BR-02]-An Invoice shall have an Invoice number (BT-1).</assert>
      <assert id="BR-03" flag="fatal" test="(cbc:IssueDate) !=''">[BR-03]-An Invoice shall have an Invoice issue date (BT-2).</assert>
      <assert id="BR-04" flag="fatal" test="(cbc:InvoiceTypeCode) !='' or (cbc:CreditNoteTypeCode) !=''">[BR-04]-An Invoice shall have an Invoice type code (BT-3).</assert>
      <assert id="BR-05" flag="fatal" test="(cbc:DocumentCurrencyCode) !=''">[BR-05]-An Invoice shall have an Invoice currency code (BT-5).</assert>
      <assert id="BR-06" flag="fatal" test="(cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) !=''">[BR-06]-An Invoice shall contain the Seller name (BT-27).</assert>
      <assert id="BR-07" flag="fatal" test="(cac:AccountingCustomerParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName) !=''">[BR-07]-An Invoice shall contain the Buyer name (BT-44).</assert>
      <assert id="BR-08" flag="fatal" test="exists(cac:AccountingSupplierParty/cac:Party/cac:PostalAddress)">[BR-08]-An Invoice shall contain the Seller postal address. </assert>
      <assert id="BR-10" flag="fatal" test="exists(cac:AccountingCustomerParty/cac:Party/cac:PostalAddress)">[BR-10]-An Invoice shall contain the Buyer postal address (BG-8).</assert>
      <assert id="BR-16" flag="fatal" test="exists(cac:InvoiceLine) or exists(cac:CreditNoteLine)">[BR-16]-An Invoice shall have at least one Invoice line (BG-25)</assert>
      <!--Rule excluded:BR-53-->
      <!--Rule excluded:BR-AE-01-->
      <!--Rule excluded:BR-AE-02-->
      <!--Rule excluded:BR-AE-03-->
      <!--Rule excluded:BR-AE-04-->
      <assert id="BR-CO-03" flag="fatal" test="(exists(cbc:TaxPointDate) and not(cac:InvoicePeriod/cbc:DescriptionCode)) or (not(cbc:TaxPointDate) and exists(cac:InvoicePeriod/cbc:DescriptionCode)) or (not(cbc:TaxPointDate) and not(cac:InvoicePeriod/cbc:DescriptionCode))">[BR-CO-03]-Value added tax point date (BT-7) and Value added tax point date code (BT-8) are mutually exclusive.</assert>
      <!--Rule excluded:BR-CO-15-->
      <!--Rule excluded:BR-CO-18-->
      <!--Rule excluded:BR-DEC-13-->
      <!--Rule excluded:BR-DEC-15-->
      <!--Rule excluded:BR-E-01-->
      <!--Rule excluded:BR-E-02-->
      <!--Rule excluded:BR-E-03-->
      <!--Rule excluded:BR-E-04-->
      <!--Rule excluded:BR-G-01-->
      <!--Rule excluded:BR-G-02-->
      <!--Rule excluded:BR-G-03-->
      <!--Rule excluded:BR-G-04-->
      <!--Rule excluded:BR-IC-01-->
      <!--Rule excluded:BR-IC-02-->
      <!--Rule excluded:BR-IC-03-->
      <!--Rule excluded:BR-IC-04-->
      <!--Rule excluded:BR-IC-11-->
      <!--Rule excluded:BR-IC-12-->
      <!--Rule excluded:BR-IG-01-->
      <!--Rule excluded:BR-IG-02-->
      <!--Rule excluded:BR-IG-03-->
      <!--Rule excluded:BR-IG-04-->
      <!--Rule excluded:BR-IP-01-->
      <!--Rule excluded:BR-IP-02-->
      <!--Rule excluded:BR-IP-03-->
      <!--Rule excluded:BR-IP-04-->
      <!--Rule excluded:BR-O-01-->
      <!--Rule excluded:BR-O-02-->
      <!--Rule excluded:BR-O-03-->
      <!--Rule excluded:BR-O-04-->
      <!--Rule excluded:BR-O-11-->
      <!--Rule excluded:BR-O-12-->
      <!--Rule excluded:BR-O-13-->
      <!--Rule excluded:BR-O-14-->
      <!--Rule excluded:BR-S-01-->
      <!--Rule excluded:BR-S-02-->
      <!--Rule excluded:BR-S-03-->
      <!--Rule excluded:BR-S-04-->
      <!--Rule excluded:BR-Z-01-->
      <!--Rule excluded:BR-Z-02-->
      <!--Rule excluded:BR-Z-03-->
      <!--Rule excluded:BR-Z-04-->
    </rule>
    <rule context="cac:InvoiceLine | cac:CreditNoteLine">
      <assert id="BR-21" flag="fatal" test="(cbc:ID) != ''">[BR-21]-Each Invoice line (BG-25) shall have an Invoice line identifier (BT-126).</assert>
      <assert id="BR-22" flag="fatal" test="exists(cbc:InvoicedQuantity) or exists(cbc:CreditedQuantity)">[BR-22]-Each Invoice line (BG-25) shall have an Invoiced quantity (BT-129).</assert>
      <assert id="BR-23" flag="fatal" test="exists(cbc:InvoicedQuantity/@unitCode) or exists(cbc:CreditedQuantity/@unitCode)">[BR-23]-An Invoice line (BG-25) shall have an Invoiced quantity unit of measure code (BT-130).</assert>
      <assert id="BR-24" flag="fatal" test="exists(cbc:LineExtensionAmount)">[BR-24]-Each Invoice line (BG-25) shall have an Invoice line net amount (BT-131).</assert>
      <assert id="BR-25" flag="fatal" test="(cac:Item/cbc:Name) != ''">[BR-25]-Each Invoice line (BG-25) shall contain the Item name (BT-153).</assert>
      <assert id="BR-26" flag="fatal" test="exists(cac:Price/cbc:PriceAmount)">[BR-26]-Each Invoice line (BG-25) shall contain the Item net price (BT-146).</assert>
      <assert id="BR-27" flag="fatal" test="(cac:Price/cbc:PriceAmount) &gt;= 0">[BR-27]-The Item net price (BT-146) shall NOT be negative.</assert>
      <assert id="BR-28" flag="fatal" test="(cac:Price/cac:AllowanceCharge/cbc:BaseAmount) &gt;= 0 or not(exists(cac:Price/cac:AllowanceCharge/cbc:BaseAmount))">[BR-28]-The Item gross price (BT-148) shall NOT be negative.</assert>
      <!--Rule excluded:BR-CO-04-->
      <assert id="BR-DEC-23" flag="fatal" test="string-length(substring-after(cbc:LineExtensionAmount,'.'))&lt;=2">[BR-DEC-23]-The allowed maximum number of decimals for the Invoice line net amount (BT-131) is 2.    </assert>
    </rule>
    <rule context="//cac:InvoiceLine/cac:AllowanceCharge[cbc:ChargeIndicator = false()] | //cac:CreditNoteLine/cac:AllowanceCharge[cbc:ChargeIndicator = false()]">
      <assert id="BR-41" flag="fatal" test="exists(cbc:Amount)">[BR-41]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance amount (BT-136).</assert>
      <assert id="BR-42" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-42]-Each Invoice line allowance (BG-27) shall have an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140).</assert>
      <assert id="BR-CO-07" flag="fatal" test="true()">[BR-CO-07]-Invoice line allowance reason code (BT-140) and Invoice line allowance reason (BT-139) shall indicate the same type of allowance reason.</assert>
      <assert id="BR-CO-23" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-CO-23]-Each Invoice line allowance (BG-27) shall contain an Invoice line allowance reason (BT-139) or an Invoice line allowance reason code (BT-140), or both.</assert>
      <assert id="BR-DEC-24" flag="fatal" test="string-length(substring-after(cbc:Amount,'.'))&lt;=2">[BR-DEC-24]-The allowed maximum number of decimals for the Invoice line allowance amount (BT-136) is 2.</assert>
      <assert id="BR-DEC-25" flag="fatal" test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2">[BR-DEC-25]-The allowed maximum number of decimals for the Invoice line allowance base amount (BT-137) is 2.    </assert>
    </rule>
    <rule context="//cac:InvoiceLine/cac:AllowanceCharge[cbc:ChargeIndicator = true()] | //cac:CreditNoteLine/cac:AllowanceCharge[cbc:ChargeIndicator = true()]">
      <assert id="BR-43" flag="fatal" test="exists(cbc:Amount)">[BR-43]-Each Invoice line charge (BG-28) shall have an Invoice line charge amount (BT-141).</assert>
      <assert id="BR-44" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-44]-Each Invoice line charge shall have an Invoice line charge reason or an invoice line allowance reason code. </assert>
      <assert id="BR-CO-08" flag="fatal" test="true()">[BR-CO-08]-Invoice line charge reason code (BT-145) and Invoice line charge reason (BT144) shall indicate the same type of charge reason.</assert>
      <assert id="BR-CO-24" flag="fatal" test="exists(cbc:AllowanceChargeReason) or exists(cbc:AllowanceChargeReasonCode)">[BR-CO-24]-Each Invoice line charge (BG-28) shall contain an Invoice line charge reason (BT-144) or an Invoice line charge reason code (BT-145), or both.</assert>
      <assert id="BR-DEC-27" flag="fatal" test="string-length(substring-after(cbc:Amount,'.'))&lt;=2">[BR-DEC-27]-The allowed maximum number of decimals for the Invoice line charge amount (BT-141) is 2.</assert>
      <assert id="BR-DEC-28" flag="fatal" test="string-length(substring-after(cbc:BaseAmount,'.'))&lt;=2">[BR-DEC-28]-The allowed maximum number of decimals for the Invoice line charge base amount (BT-142) is 2.    </assert>
    </rule>
    <rule context="cac:InvoiceLine/cac:InvoicePeriod | cac:CreditNoteLine/cac:InvoicePeriod">
      <assert id="BR-30" flag="fatal" test="(exists(cbc:EndDate) and exists(cbc:StartDate) and xs:date(cbc:EndDate) &gt;= xs:date(cbc:StartDate)) or not(exists(cbc:StartDate)) or not(exists(cbc:EndDate))">[BR-30]-If both Invoice line period start date (BT-134) and Invoice line period end date (BT-135) are given then the Invoice line period end date (BT-135) shall be later or equal to the Invoice line period start date (BT-134).</assert>
      <assert id="BR-CO-20" flag="fatal" test="exists(cbc:StartDate) or exists(cbc:EndDate)">[BR-CO-20]-If Invoice line period (BG-26) is used, the Invoice line period start date (BT-134) or the Invoice line period end date (BT-135) shall be filled, or both.</assert>
    </rule>
    <rule context="cac:InvoicePeriod">
      <assert id="BR-29" flag="fatal" test="(exists(cbc:EndDate) and exists(cbc:StartDate) and xs:date(cbc:EndDate) &gt;= xs:date(cbc:StartDate)) or not(exists(cbc:StartDate)) or not(exists(cbc:EndDate))">[BR-29]-If both Invoicing period start date (BT-73) and Invoicing period end date (BT-74) are given then the Invoicing period end date (BT-74) shall be later or equal to the Invoicing period start date (BT-73).</assert>
      <assert id="BR-CO-19" flag="fatal" test="exists(cbc:StartDate) or exists(cbc:EndDate) or (exists(cbc:DescriptionCode) and not(exists(cbc:StartDate)) and not(exists(cbc:EndDate)))">[BR-CO-19]-If Invoicing period (BG-14) is used, the Invoicing period start date (BT-73) or the Invoicing period end date (BT-74) shall be filled, or both.</assert>
    </rule>
    <rule context="//cac:AdditionalItemProperty">
      <assert id="BR-54" flag="fatal" test="exists(cbc:Name) and exists(cbc:Value)">[BR-54]-Each Item attribute (BG-32) shall contain an Item attribute name (BT-160) and an Item attribute value (BT-161).</assert>
    </rule>
    <rule context="cac:InvoiceLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode | cac:CreditNoteLine/cac:Item/cac:CommodityClassification/cbc:ItemClassificationCode">
      <assert id="BR-65" flag="fatal" test="exists(@listID)">[BR-65]-The Item classification identifier (BT-158) shall have a Scheme identifier.</assert>
    </rule>
    <rule context="cac:InvoiceLine/cac:Item/cac:StandardItemIdentification/cbc:ID | cac:CreditNoteLine/cac:Item/cac:StandardItemIdentification/cbc:ID">
      <assert id="BR-64" flag="fatal" test="exists(@schemeID)">[BR-64]-The Item standard identifier (BT-157) shall have a Scheme identifier.</assert>
    </rule>
    <rule context="/ubl:Invoice/cbc:Note | /cn:CreditNote/cac:Note">
      <assert id="BR-CL-08" flag="fatal" test="(contains(.,'#') and ( ( contains(' AAA AAB AAC AAD AAE AAF AAG AAI AAJ AAK AAL AAM AAN AAO AAP AAQ AAR AAS AAT AAU AAV AAW AAX AAY AAZ ABA ABB ABC ABD ABE ABF ABG ABH ABI ABJ ABK ABL ABM ABN ABO ABP ABQ ABR ABS ABT ABU ABV ABW ABX ABZ ACA ACB ACC ACD ACE ACF ACG ACH ACI ACJ ACK ACL ACM ACN ACO ACP ACQ ACR ACS ACT ACU ACV ACW ACX ACY ACZ ADA ADB ADC ADD ADE ADF ADG ADH ADI ADJ ADK ADL ADM ADN ADO ADP ADQ ADR ADS ADT ADU ADV ADW ADX ADY ADZ AEA AEB AEC AED AEE AEF AEG AEH AEI AEJ AEK AEL AEM AEN AEO AEP AEQ AER AES AET AEU AEV AEW AEX AEY AEZ AFA AFB AFC AFD AFE AFF AFG AFH AFI AFJ AFK AFL AFM AFN AFO AFP AFQ AFR AFS AFT AFU AFV AFW AFX AFY AFZ AGA AGB AGC AGD AGE AGF AGG AGH AGI AGJ AGK AGL AGM AGN AGO AGP AGQ AGR AGS AGT AGU AGV AGW AGX AGY AGZ AHA AHB AHC AHD AHE AHF AHG AHH AHI AHJ AHK AHL AHM AHN AHO AHP AHQ AHR AHS AHT AHU AHV AHW AHX AHY AHZ AIA AIB AIC AID AIE AIF AIG AIH AII AIJ AIK AIL AIM AIN AIO AIP AIQ AIR AIS AIT AIU AIV AIW AIX AIY AIZ AJA AJB ALC ALD ALE ALF ALG ALH ALI ALJ ALK ALL ALM ALN ALO ALP ALQ ARR ARS AUT AUU AUV AUW AUX AUY AUZ AVA AVB AVC AVD AVE AVF BAG BAH BAI BAJ BAK BAL BAM BAN BAO BAP BAQ BLC BLD BLE BLF BLG BLH BLI BLJ BLK BLL BLM BLN BLO BLP BLQ BLR BLS BLT BLU BLV BLW BLX BLY BLZ BMA BMB BMC BMD BME CCI CEX CHG CIP CLP CLR COI CUR CUS DAR DCL DEL DIN DOC DUT EUR FBC GBL GEN GS7 HAN HAZ ICN IIN IMI IND INS INV IRP ITR ITS LAN LIN LOI MCO MDH MKS ORI OSI PAC PAI PAY PKG PKT PMD PMT PRD PRF PRI PUR QIN QQD QUT RAH REG RET REV RQR SAF SIC SIN SLR SPA SPG SPH SPP SPT SRN SSR SUR TCA TDT TRA TRR TXD WHI ZZZ ',substring-before(substring-after(.,'#'),'#') ) ) )) or not(contains(.,'#'))">[BR-CL-08]-Invoiced note subject code SHOULD be coded using UNCL4451</assert>
    </rule>
    <rule context="cac:PayeeParty">
      <assert id="BR-17" flag="fatal" test="exists(cac:PartyName/cbc:Name) and (not(cac:PartyName/cbc:Name = ../cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name) and not(cac:PartyIdentification/cbc:ID = ../cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID) and not(cac:PartyLegalEntity/cbc:RegistrationName = ../cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName))">[BR-17]-The Payee name (BT-59) shall be provided in the Invoice, if the Payee (BG-10) is different from the Seller (BG-4)</assert>
    </rule>
    <rule context="cac:PaymentMeans[cbc:PaymentMeansCode='30' or cbc:PaymentMeansCode='58']/cac:PayeeFinancialAccount">
      <assert id="BR-50" flag="fatal" test="(cbc:ID) != ''">[BR-50]-A Payment account identifier (BT-84) shall be present if Credit transfer (BG-17) information is provided in the Invoice.</assert>
    </rule>
    <rule context="cac:PaymentMeans">
      <assert id="BR-49" flag="fatal" test="exists(cbc:PaymentMeansCode)">[BR-49]-A Payment instruction (BG-16) shall specify the Payment means type code (BT-81).</assert>
      <assert id="BR-61" flag="fatal" test="(exists(cac:PayeeFinancialAccount/cbc:ID) and ((normalize-space(cbc:PaymentMeansCode) = '30') or (normalize-space(cbc:PaymentMeansCode) = '58') )) or ((normalize-space(cbc:PaymentMeansCode) != '30') and (normalize-space(cbc:PaymentMeansCode) != '58'))">[BR-61]-If the Payment means type code (BT-81) means SEPA credit transfer, Local credit transfer or Non-SEPA international credit transfer, the Payment account identifier (BT-84) shall be present.</assert>
    </rule>
    <rule context="cac:BillingReference">
      <assert id="BR-55" flag="fatal" test="exists(cac:InvoiceDocumentReference/cbc:ID)">[BR-55]-Each Preceding Invoice reference (BG-3) shall contain a Preceding Invoice reference (BT-25).</assert>
    </rule>
    <rule context="cac:AccountingSupplierParty">
      <!--Rule excluded:BR-CO-26-->
    </rule>
    <rule context="cac:AccountingSupplierParty/cac:Party/cbc:EndpointID">
      <assert id="BR-62" flag="fatal" test="exists(@schemeID)">[BR-62]-The Seller electronic address (BT-34) shall have a Scheme identifier.</assert>
    </rule>
    <rule context="cac:AccountingSupplierParty/cac:Party/cac:PostalAddress">
      <assert id="BR-09" flag="fatal" test="(cac:Country/cbc:IdentificationCode) != ''">[BR-09]-The Seller postal address (BG-5) shall contain a Seller country code (BT-40).</assert>
    </rule>
    <rule context="cac:TaxRepresentativeParty">
      <assert id="BR-18" flag="fatal" test="(cac:PartyName/cbc:Name) != ''">[BR-18]-The Seller tax representative name (BT-62) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11)</assert>
      <assert id="BR-19" flag="fatal" test="exists(cac:PostalAddress)">[BR-19]-The Seller tax representative postal address (BG-12) shall be provided in the Invoice, if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
      <!--Rule excluded:BR-56-->
    </rule>
    <rule context="cac:TaxRepresentativeParty/cac:PostalAddress">
      <assert id="BR-20" flag="fatal" test="(cac:Country/cbc:IdentificationCode) != ''">[BR-20]-The Seller tax representative postal address (BG-12) shall contain a Tax representative country code (BT-69), if the Seller (BG-4) has a Seller tax representative party (BG-11).</assert>
    </rule>
   
   </pattern>