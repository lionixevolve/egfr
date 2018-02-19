#! /bin/bash
list=$(<4pdbs.list)
declare -a linea
i=0
template='template.py'
for file in $list
do
        i=`expr $i + 1`
	k=0
	cont=0
	flag=0
	cd $file
	file_full=${file/*/"$file"_full}
	alignment='alignment'
	canonical='canonical'
	tomodel='to-model'
	missings='missings'

	./emiss-finder.exe $alignment $missings $file $canonical
	while read dato
	do
        k=`expr $k + 1`
        linea[k]=$dato
	done < $missings

	for (( m=1; m<=$k; m++ ))
	do
		for side in ${linea[m]}
		do
			if [ $flag -eq 1 ]
	                then
				right[m]=$side
				flag=0
			
			elif [ $flag -eq 0 ]
	                then
				left[m]=$side
				flag=1
			fi
		done
	done

	head -n11 ./../'template.py' >> 'mode.py'
	
	echo "	return selection(self.residue_range('"${left[1]}"', '"${right[1]}"')," >> 'mode.py'
	for (( m=2; m<$k; m++ ))
        do
		echo "			 self.residue_range('${left[m]}', '${right[m]}')," >> 'mode.py'
	done
	echo "	  		 self.residue_range('${left[k]}', '${right[k]}'),)" >> 'mode.py'
	echo " " >> 'mode.py'
	echo "a = MyModel(env, alnfile = 'to-model'," >> 'mode.py'
        echo "	    knowns = '"$file"', sequence = '"$file_full"')" >> 'mode.py'  
	tail -n4 ./../'template.py' >> 'mode.py'

	mod9.14 mode.py
	cd ..
done
