#!/bin/bash
#
REFERENCE="AB550331.1";
#
n=1;
name_data="";
ls -la S*.csv | awk '{ print $9}' | sort -V > tmp_file.tmp;
mapfile -t ENTRIES < tmp_file.tmp;
#
for ENTRY in "${ENTRIES[@]}" #
  do
  echo "processing [$n] $ENTRY ...";
  bash GetData.sh $ENTRY $REFERENCE $n > ENT-$n.txt;
  if [ -s ENT-$n.txt ]; 
    then
    tmp_data="'ENT-$n.txt' using 2:1:(myPt(4)):(myColor(3)) title '$n' w p ps 0.2 pt var lc rgb var, ";
    name_data=$name_data$tmp_data;
    fi
  ((++n));
  done
rm -f tmp_file.tmp;
#
SIZE=`efetch -format fasta -id "$REFERENCE" -db nucleotide | gto_fasta_to_seq | wc -c | awk '{ print $1}'`;
echo "Genome size  = $SIZE";
echo "Entries size = $((--n))";
#echo "$name_data";
#
gnuplot << EOF
    reset
    set terminal pdfcairo enhanced color font 'Verdade,9'
    set output "Profile.pdf"
    set style line 101 lc rgb '#000000' lt 1 lw 4
    set border 3 front ls 101
    set tics nomirror out scale 0.5
    set format '%g'
    set size ratio 0.24
    set key out horiz center top
    set yrange [0:$n]
    set xrange [0:$SIZE]
    set xtics auto
    set ytics auto
    unset grid
    set ylabel "Sequence"
    set xlabel "Length"
    set border linewidth 1.5
#    myColor(col) = column(col)==1 ? 0x00ff00 : column(col)==0 ? 0xff0000 : 0xcccccc
    myColor(col) = column(col)==1 ? 0x990099 : column(col)==0 ? 0x004C99 : 0xCCCC00
    myPt(col)    = column(col)==1 ? 1 : 6
    set style line 1 lc rgb '#990099'  pt 6 ps 0.2  # circle
    set style line 2 lc rgb '#004C99'  pt 6 ps 0.2  # circle
    set style line 3 lc rgb '#CCCC00'  pt 6 ps 0.2  # circle
    set style line 4 lc rgb '#4C0099'  pt 6 ps 0.2  # circle
    set style line 5 lc rgb '#009900'  pt 6 ps 0.2  # circle
    set style line 6 lc rgb '#990000'  pt 6 ps 0.2  # circle
    set style line 7 lc rgb '#009999'  pt 6 ps 0.2  # circle
    set style line 8 lc rgb '#99004C'  pt 6 ps 0.2  # circle
    set style line 9 lc rgb '#CC6600'  pt 6 ps 0.2  # circle
    set style line 10 lc rgb '#322152' pt 6 ps 0.2  # circle
    set xtics border in scale 0,0 nomirror rotate by -55  autojustify
    set xtics  norangelimit  font ",8"
    plot $name_data
EOF
#
evince Profile.pdf &
#
