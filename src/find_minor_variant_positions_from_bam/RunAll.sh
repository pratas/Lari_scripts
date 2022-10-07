#!/bin/bash
#
#conda install -c bioconda ivar="1.3.1" -y
#how to create a GFF3 file
#
THRESHOLD="0.03";
#
bash Find_minor_variant_positions_from_bam.sh SPECIFIC.fa RD-SORT-FIL-SPECIFIC-READS.bam HAIR POLY5 $THRESHOLD
#
