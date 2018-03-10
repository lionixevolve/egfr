#! /bin/bash
list=$(<im.list)
i=0

echo  " Rg" >> im_originals_rg

for file in $list
do

    file_vector=${file/*/"$file"_"$modo"_"$displ"}

    rg=`~/mmtsb/perl/rgyr.pl $file`
    echo  "$file $rg" >> im_originals_rg

done
exit 0
