#! /bin/bash
list=$(<pdbs.list)
lista=$(<pdbs.list)
#list="1XKK_A"
i=0
for file in $list
do
    echo -------- $file -------  
    mkdir $file
    cp ../gram/$file/*bfmod* $file/    
done
