#! /bin/bash
list=$(<pdbs.list)
lista=$(<pdbs.list)
#list="1XKK_A"
i=0
for file in $list
do
    echo -------- $file -------  
    
    i=`expr $i + 1`
    pdb=$file.pdb
    file_mods=modos_${file}
################################
################################
    cd $file

#    for refile in $lista
#    do
#        if [[ $file == $refile ]]
#        then
#            continue
#        fi
#        echo $refile
#        cp ../$refile/freq_$refile .
#    done


#    cp ../src/eold_bipond.exe .
#    cp ../src/esort_fq_old.exe .
#    cp ../src/eold_bigram.exe .
#    cp ../src/emin.exe .
#    cp ../aa_pocket .
    
    rm *vec*
    cd ..
done
