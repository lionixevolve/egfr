#! /bin/bash
list=$(<pdbs.list)
i=0
for file in $list
do
        i=`expr $i + 1`
	cp $file/fort.66 mut/$file	
done
