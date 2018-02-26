#! /bin/bash
list=$(<pdbs.list)
#list="1XKK_A"
i=0
for file in $list
do
    echo -------- $file -------  
    
    i=`expr $i + 1`
    nonrot_pdb=nonrot_$file.pdb
    pdb=$file.pdb
    file_dis=${file}_dis
    file_hb2=${file}.hb2

#    file_h=${file}_h
#    file_h_norm=${file}_h_norm
#    file_dis=${file}_dis
    
    file_mods=modos_${file}
    rm $file/*ord
    rm $file/*nsub

done
