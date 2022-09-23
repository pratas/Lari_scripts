#!/bin/bash
#
# bash GetData.sh S39-I14-colon-B19.csv AB550331.1 2
#
cat $1 \
| grep "$2" \
| tr ';' '\t' \
| awk '{ print $2"\t"$4"\t"$17"\t"$19;}' > tmp.t
#
if [ ! -f "tmp.t" ]; 
  then
  echo "ERROR: Input file tmp.t does not exists!";
  exit;
fi
#
mapfile -t FIELDS < tmp.t
#
for pos in "${FIELDS[@]}" #
  do
  #
  P1=`echo $pos | awk '{ print $1 }'`;
  P2=`echo $pos | awk '{ print $2 }'`;
  P3=`echo $pos | awk '{ print $3 }'`;
  P4=`echo $pos | awk '{ print $4 }'`;
  #
  CHARGE="0";
  CHARGE_TMP=`echo "$P2" | head -c 1`;
  if [[ "$CHARGE_TMP" == "+" ]];
    then
    CHARGE="2";
  elif [[ "$CHARGE_TMP" == "-" ]];
    then
    CHARGE=0;
  else
    CHARGE=1;
    fi
  #
  SYNCRONOS="0";
  if [[ "$P3" == "$P4" ]];
    then
    SYNCRONOS="1";
    fi
  #
  echo "$3 $P1 $CHARGE $SYNCRONOS";
  #
  #
  done
