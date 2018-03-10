#! /bin/bash
list=$(<im.list)
i=0

for file in $list
do
    echo -------- $file -------  
    pdb=$file.pdb
    file_vec1_20=${file/*/"$file"_vec1_2.pdb}
    file_vec1__20=${file/*/"$file"_vec1__2.pdb}
    
    file_vec2_20=${file/*/"$file"_vec2_2.pdb}
    file_vec2__20=${file/*/"$file"_vec2__2.pdb}

    rg=`/home/german/mmtsb/perl/rgyr.pl $file/$pdb`
    rg_vec1_2=`/home/german/mmtsb/perl/rgyr.pl $file/$file_vec1_20`
    rg_vec1__2=`/home/german/mmtsb/perl/rgyr.pl $file/$file_vec1__20`

    rg_vec2_2=`/home/german/mmtsb/perl/rgyr.pl $file/$file_vec2_20`
    rg_vec2__2=`/home/german/mmtsb/perl/rgyr.pl $file/$file_vec2__20`

    echo $rg >> rad_im
    echo $rg_vec1_2 >> rad_im_vec1_mas
    echo $rg_vec1__2 >> rad_im_vec1_men

    echo $rg_vec2_2 >> rad_im_vec2_mas
    echo $rg_vec2__2 >> rad_im_vec2_men
done
exit 0
