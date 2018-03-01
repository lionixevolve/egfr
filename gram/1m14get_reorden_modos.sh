#! /bin/bash
list="1M14_A"
lista=$(<pdbs.list)
#list="1XKK_A"
i=0
for file in $list
do
    echo -------- $file -------  
    
    i=`expr $i + 1`
    nonrot_pdb=nonrot_$file.pdb
    pdb=$file.pdb
    file_dis=${file}_dis
    file_hb2=${file}.hb2
    hb_file=hb_${file}
    cutoff_a=10

# estos son los nombres de los archivos de out q me va a g.rar 'epanmhs.exe'
    file_bf=bf_${file}
    file_bfcorr=bfcorr_${file}
    file_bfteo=bfteo_${file}
    file_colec=colec_${file}
    file_correl=correl_${file}
    file_freq=freq_${file}
    file_mods=modos_${file}

################################
################################

    cd $file

    for refile in $lista
    do
        if [[ $file == $refile ]] 
        then
            continue
        fi

        refile_mods=modos_${refile}
        refile_ord=${file}_${refile}_ord
        refile_nsub=${file}_${refile}_nsub

        cp ../$refile/$refile_mods .
        ./emin.exe $file_mods $refile_mods 825 $refile_ord $refile_nsub
    done


    cd ..
done
