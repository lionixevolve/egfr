#! /bin/bash
list=$(<am.list)
i=0

for file in $list
do
	file_CA=${file/*/"$file"_CA}
	file_vec1_10=${file/*/"$file"_vec1_1}
	file_vec1_20=${file/*/"$file"_vec1_2}
	file_vec1_30=${file/*/"$file"_vec1_3}
	file_vec1_40=${file/*/"$file"_vec1_4}
	file_vec1_60=${file/*/"$file"_vec1_6}
	file_vec1_80=${file/*/"$file"_vec1_8}

        file_vec2_10=${file/*/"$file"_vec2_1}
	file_vec2_20=${file/*/"$file"_vec2_2}
	file_vec2_30=${file/*/"$file"_vec2_3}
	file_vec2_40=${file/*/"$file"_vec2_4}
	file_vec2_60=${file/*/"$file"_vec2_6}
	file_vec2_80=${file/*/"$file"_vec2_8}
        am_1="svd_am1"
        am_2="svd_am2"

        ./edisplace.exe ../data/pdbs_modos/$file $am_1 $file_vec1_10 1
        ./edisplace.exe ./$file_vec1_10 $am_1 $file_vec1_20 1
        ./edisplace.exe $file_vec1_20 $am_1 $file_vec1_30 1
        ./edisplace.exe $file_vec1_30 $am_1 $file_vec1_40 1
        ./edisplace.exe $file_vec1_40 $am_1 $file_vec1_60 2
        ./edisplace.exe $file_vec1_60 $am_1 $file_vec1_80 2

        ./edisplace.exe ../data/pdbs_modos/$file $am_2 $file_vec2_10 1
        ./edisplace.exe $file_vec2_10 $am_2 $file_vec2_20 1
        ./edisplace.exe $file_vec2_20 $am_2 $file_vec2_30 1
        ./edisplace.exe $file_vec2_30 $am_2 $file_vec2_40 1
        ./edisplace.exe $file_vec2_40 $am_2 $file_vec2_60 2
        ./edisplace.exe $file_vec2_60 $am_2 $file_vec2_80 2

done
exit 0
