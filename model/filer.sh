#! /bin/bash
list=$(<pdbs.list)
i=0
for file in $list
do
        i=`expr $i + 1`
        pdb=$file.pdb

        #mkdir $file
        #mv $pdb $file

        rm $file/to-model_$file
	#cp canonical $file
	#cp source/emiss-finder.exe $file


	#rm eseq_appender.exe
	#rm eclustal-pir.exe
	#rm $file/mode*
	#rm $file/
	#rm $file/*full.*
	#cp $file/*.B* re_medusa/$file/
done
