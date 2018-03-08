#! /bin/bash
list=$(<pdbs.list)
i=0
for file in $list
do
    echo -------- $file -------  
    
    # cd $file

    mkdir $file
    cp ../$file/*bfmod* $file

    # cd ..
done
