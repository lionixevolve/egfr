#! /bin/bash
list=$(<pdbs.list)
list="1XKK_A"
i=0
for file in $list
do
    echo -------- $file -------  
    
    i=`expr $i + 1`
    nonrot_pdb=nonrot_$file.pdb
    pdb=$file.pdb
    pdb_dis=${file}_dis


    cd $file
    ./edis.exe $pdb $pdb_dis
    ./hbplus $pdb
    cd ..
done
