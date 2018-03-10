#! /bin/bash
list=$(<am.list)
i=0

echo  " Rg" >> am_originals_rg

for file in $list
do

    file_vector=${file/*/"$file"_"$modo"_"$displ"}

    rg=`rgyr.pl ../data/pdbs_modos/$file`
    echo  "$file $rg" >> am_originals_rg

done
exit 0
