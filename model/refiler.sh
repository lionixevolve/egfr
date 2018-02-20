#! /bin/bash
list=$(<pdbs.list)
i=0
for file in $list
do
        echo -----------------------
        echo -------- $file -------  
        echo -----------------------
        
        i=`expr $i + 1`
        pdb=$file.pdb

        #mkdir $file
        #mv $pdb $file

	#cp canonical $file
	#cp source/emiss-finder.exe $file


	#rm eseq_appender.exe
	#rm eclustal-pir.exe
	#rm $file/mode*
	#rm $file/
	#rm $file/*full.*
	#cp $file/*.B* re_medusa/$file/


    cd $file
    for ((j=1;j<51;j++))
    do
            script_filename=script_eval_${file}_${j}.py
            mod9.19 $script_filename
    done
    cd ..

done
