#! /bin/bash
#list=$(<pdbs.list)
list='2RFE_B'
i=0
for file in $list
do
        i=`expr $i + 1`
	cd $file
	seq=${file/*/"$file".ali}
        struct=${file/*/"$file".pir}
        pdb=${file/*/"$file".pdb}
	alignment='alignment'
	canonical='canonical'
	tomodel='to-model'
#	needle $canonical $struct -gapopen 10.0 -gapextend 0.5 $alignment
	./eneedle-pir.exe $alignment $tomodel $file $canonical $struct

	cd ..
#	./eseq_appender.exe $seq $struct $alignment
#	clustalw 'alignment'
#	rm 'alignment.dnd'
#	./eclustal-pir.exe 'alignment.aln' 'alignment.ali' $file $file
	
done
