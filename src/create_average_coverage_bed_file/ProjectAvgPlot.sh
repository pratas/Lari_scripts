#!/bin/bash
#
LPATH="$1";
ID="NoId";
#
printf "chromosome\tposition\ty\n" > $LPATH-all-organs-merged-average-sum.csv;
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
  if [[ "$n" -eq "1" ]];
    then
    ID=`head -n 1 $ENTRY | awk '{ print $1;}'`;
    fi
  ((++n));
  done
echo "Reference: $ID";
paste $name_data | awk 'BEGIN{k=0M;}{ sumrows=0;
    for (i=1; i<=NF; i++) 
      {
      sumrows+= $i 
      }; 
    print "'$ID'""\t"++k"\t"sumrows/NF
}' >> $LPATH-all-organs-merged-average-sum.csv;
#
rm -f tmp_file.tmp
#
