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
    hb_file=hb_${file}

    file_mods=modos_${file}

    modo_1=1modo_${file}
    modo_2=2modo_${file}
################################
################################
#    cd $file

    julia sacar_modos.jl $file/$file_mods $file/$modo_1 $file/$modo_2   
    

#    cd ..
done
