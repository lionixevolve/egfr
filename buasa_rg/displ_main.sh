#! /bin/bash
list=$(<pdbs.list)
i=0

for file in $list
do
	file_main_10=${file/*/"$file"_vecmain_1}
	file_main_20=${file/*/"$file"_vecmain_2}
	file_main_30=${file/*/"$file"_vecmain_3}
	file_main_40=${file/*/"$file"_vecmain_4}
	file_main_60=${file/*/"$file"_vecmain_6}
	file_main_80=${file/*/"$file"_vecmain_8}
        vec_main=${file/*/main_"$file"}

        ./edisplace.exe ../data/pdbs_modos/$file ../data/modos_main/$vec_main $file_main_10 1
        ./edisplace.exe $file_main_10  ../data/modos_main/$vec_main $file_main_20 1
        ./edisplace.exe $file_main_20 ../data/modos_main/$vec_main $file_main_30 1
        ./edisplace.exe $file_main_30 ../data/modos_main/$vec_main $file_main_40 1
        ./edisplace.exe $file_main_40 ../data/modos_main/$vec_main $file_main_60 2
        ./edisplace.exe $file_main_60 ../data/modos_main/$vec_main $file_main_80 2

done
exit 0
