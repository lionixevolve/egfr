#! /bin/bash
list="1M14_A"
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
    cd $file

    ANA $pdb -c ../egfr.cfg --NDD_input=in_ndd_$file --NDD_output=out_ndd_$file > vol_$file

    cd ..
done
