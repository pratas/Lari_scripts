#!/bin/bash
#
function DO_REGIONS {
  #
  EMAIL="$1";
  ID="$2";
  WINDOW="$3";
  #
  echo "Running $ID with window $WINDOW ..."
  efetch -format fasta -db nucleotide -id $ID > $ID.fa
  ./AlcoR mapper -v -w $WINDOW -t 1.5 --dna -m 13:50:0:1:10:0.9/5:10:0.9 $ID.fa > $ID.regions;
  echo ":)" | mail -s "Attach with regions $ID using window $WINDOW" -A $ID.regions $EMAIL
  }
#
T_EMAIL="lari.pyoria@helsinki.fi";
#
DO_REGIONS "$T_EMAIL" "MG298924.1" "50";
DO_REGIONS "$T_EMAIL" "HM011544.1" "1";
DO_REGIONS "$T_EMAIL" "AF037218.1" "50";
DO_REGIONS "$T_EMAIL" "AJ871403.1" "50";
DO_REGIONS "$T_EMAIL" "MH999850.1" "50";
DO_REGIONS "$T_EMAIL" "KJ361955.1" "50";
#
