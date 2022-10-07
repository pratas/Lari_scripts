#!/bin/bash
#
# ./Find_minor_variant_positions_from_bam.sh H_N-HV6B.fa viral_aligned_sorted-H_N-HV6B.bam H_N HV6B 0.2
#
Reference=$1;     # EXAMPLE: TTV.fa
Alignments=$2;    # EXAMPLE: ttv_aligned_sorted-heart.bam
Organ=$3;         # Example: heart
Label=$4;         # Example: TTV
Threshold=$5;     # Example: 0.10
#
echo "Using Reference   : $Reference";
echo "Using Alignments  : $Alignments";
echo "Using Organ       : $Organ";
echo "Using Viral Label : $Label";
echo "Threshold         : $Threshold";
#
OUTPUT_DIR="ivar_results";
mkdir -p $OUTPUT_DIR
#
rm -f $SID.gff3;
SID=`head $Reference | grep ">" | tr -d ">" | awk '{ print $1;}'`;
wget -O $SID.gff3 "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?db=nucleotide&report=gff3&id=$SID" 2>> $OUTPUT_DIR/Log-stderr.txt
samtools mpileup -aa -A -d 600000 -B -Q 0 $Alignments | ivar variants -p $OUTPUT_DIR/Variants-$Organ-$Label -q 20 -t $Threshold -r $Reference -g $SID.gff3
cp $SID.gff3 $OUTPUT_DIR/Gff-$Organ-$SID.gff3
#
