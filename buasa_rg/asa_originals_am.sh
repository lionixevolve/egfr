#! /bin/bash
list=$(<am.list)
i=0

echo  " ASA" >> asa_am_originals

for file in $list
do

    file_vector=${file/*/"$file"_"$modo"_"$displ"}

    asa=`freesasa  ../data/pdbs_modos/$file | tail -4 | head -1 | awk '{print $3}'`
    echo  "$file $asa" >> asa_am_originals

done
exit 0
