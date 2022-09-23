#!/bin/bash
#
LPATH="$1";
#
ls -la $LPATH-*.bed | awk '{ print $9}' | sort -n > tmp_file.tmp;
mapfile -t ENTRIES < tmp_file.tmp;
#
n=1;
name_data="";
for ENTRY in "${ENTRIES[@]}" #
  do
  echo "processing [$n] $ENTRY ...";
  bash Project.sh $ENTRY | awk '{ print $2;}' > POINTS-$n.csv;
  tmp_data="POINTS-$n.csv ";
  name_data="$name_data$tmp_data";
  ((++n));
  done
paste $name_data | awk 'BEGIN{k=0}{ sumrows=0;
    for (i=1; i<=NF; i++) 
      {
      sumrows+= $i 
      }; 
    print ++k"\t"sumrows+0
}' > $LPATH-all-organs-merged.csv;
#
rm -f tmp_file.tmp
#
