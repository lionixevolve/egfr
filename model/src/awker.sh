#! /bin/bash
list=$(<pdbs.list)
declare -a linea
i=0
k=0
cont=0
template='template.py'
for file in $list
do
        i=`expr $i + 1`
	cd esso
#	seq=${file/*/"$file".ali}
#       struct=${file/*/"$file".pir}
#       pdb=${file/*/"$file".pdb}
#	alignment='alignment'
#	canonical='canonical'
#	tomodel='to-model'
	mutations=$(<mutations)
	m=$(wc -l < mutations)
	for (( k=1; k<=$m; k+=2 ))
	do
		echo $mutations | awk '{print $$"k"}'
		echo $k
		kk=`expr $k + 1`
#		echo $mutations | awk '{print $kk}'
	done
	cd ..
done
