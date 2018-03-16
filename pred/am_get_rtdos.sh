#! /bin/bash

list=$(<pred.list)
lista=$(<am.list)
i=0

for file in $list
do
    echo > zeta_pred_am_$file
    echo > nd_pred_am_$file

    echo -------- $file -------  

    for refile in $lista
    do
        if [[ $file == $refile ]]
        then
            echo "está en la lista!"
            continue
        fi
        echo $refile

        echo $refile > tmp
        cat $file/zeta_${file}_${refile} >> tmp
        paste zeta_pred_am_$file tmp > zeta_predm_am_$file
        mv zeta_predm_am_$file zeta_pred_am_$file
    
        echo $file > tmp
        cat $file/nd_${file}_${refile} >> tmp
        paste nd_pred_am_$file tmp > nd_predm_am_$file
        mv nd_predm_am_$file nd_pred_am_$file
    done    

done
