#! /bin/bash
#########################################
# filtro
##########################################


lista_1=$(<$1)
lista_2=$(<$2)

i=0
for file_1 in $lista_1
do
        
    flag=0
    for file_2 in $lista_2
    do
        if [[ $file_2 == $file_1 ]]
        then
            flag=1
            break
        fi
    done
    if [[ $flag -eq 1 ]]
    then
        echo $file_1
    fi
done
