#! /bin/bash
list=$(<im.list)
i=0
vectores=( vec1 vec2 vecmode1 vecmode2 vecmain )

for modo in ${vectores[@]}
do
    echo $modo
    outfile=${modo/*/im_mtx_asa_"$modo"}
    echo " 1 2 3 4 6 8 10 20 30 40 60 80" >> $outfile

    for file in $list
    do
        echo -n "$file " >> $outfile

        for displ in  1 2 3 4 6 8 10 20 30 40 60 80 
        do
            file_vector=${file/*/"$file"_"$modo"_"$displ"}

            asa=`freesasa  $file_vector | tail -4 | head -1 | awk '{print $3}'`
            echo -n "$asa " >> $outfile
        done

        echo "" >> $outfile        
    done
done
exit 0
