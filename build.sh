#!/bin/sh

PROJECT=$(dirname $(readlink -f "$0"))

if [ -e $PROJECT/target ]; then
    docker run --rm -i -v $PROJECT:/src alpine:3.6 rm -rf /src/target
fi

# Structure
docker run --rm -i \
    -v $PROJECT:/src \
    -v $PROJECT/target:/target \
    difi/vefa-structure:0.6


# Validator
docker run --rm -i -v $PROJECT:/src anskaffelser/validator:2.1.0 build -x -t -n eu.peppol.postaward.v3.billing -a rules,guide -target target/validator /src


# Generate adoc-files from rules

# CEN-EN16931-CII
#docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-CII.sch -q:tools/xquery/rules_asciidoc_cen.xquery -o:/target/CEN-EN16931-CII-GENERAL.sch.adoc
#docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/CEN-EN16931-CII.sch -q:tools/xquery/rules_asciidoc_cen_syntax.xquery -o:/target/CEN-EN16931-CII-SYNTAX.sch.adoc
for sch in $PROJECT/rules/sch/*.sch; do
    docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/schematron:/target klakegg/schematron prepare /src/rules/sch/$(basename $sch) /target/$(basename $sch)
done
#all rules
docker run --rm -i -v $PROJECT/target/site/files:/src alpine:3.6 rm -rf /src/SG-Peppol-BIS-Billing_3-Rules-Schematron.zip
docker run --rm -i -v $PROJECT/target/schematron:/src -v $PROJECT/target/site/files/:/target -w /src kramos/alpine-zip -r /target/SG-Peppol-BIS-Billing_3-Rules-Schematron.zip .
#SG-Rules
docker run --rm -i -v $PROJECT/target/site/files:/src alpine:3.6 rm -rf /src/SG-Peppol-BIS-Billing_3-SG-Rules-Schematron.zip
docker run --rm -i -v $PROJECT/target/schematron:/src -v $PROJECT/target/site/files/:/target -w /src kramos/alpine-zip -r /target/SG-Peppol-BIS-Billing_3-SG-Rules-Schematron.zip .
#International rules
docker run --rm -i -v $PROJECT/target/site/files:/src alpine:3.6 rm -rf /src/SG-Peppol-BIS-Billing_3-International-Rules-Schematron.zip
docker run --rm -i -v $PROJECT/target/schematron/SG-Peppol-BIS-Billing_3-International-Rules.sch:/src -v $PROJECT/target/site/files/:/target -w /src kramos/alpine-zip -r /target/SG-Peppol-BIS-Billing_3-International-Rules-Schematron.zip .


# SG-EN16931-International Rules
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/SG-Peppol-BIS-Billing_3-International-Rules.sch -q:tools/xquery/rules_asciidoc_cen.xquery -o:/target/SG-Peppol-BIS-Billing_3-International-Rules.sch.adoc


# PEPPOL-EN16931-UBL
docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/generated:/target --entrypoint java klakegg/saxon:9.8.0-7 -cp /saxon.jar net.sf.saxon.Query -s:/src/rules/sch/SG-Peppol-BIS-Billing_3-SG-Rules.sch -q:tools/xquery/rules_asciidoc_peppol.xquery -o:/target/SG-Peppol-BIS-Billing_3-SG-Rules.sch.adoc



# Guides
docker run --rm -i -v $PROJECT:/documents -v $PROJECT/target:/target difi/asciidoctor


# Fix ownership
docker run --rm -i -v $PROJECT:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
