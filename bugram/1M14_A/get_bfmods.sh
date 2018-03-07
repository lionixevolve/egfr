#! /bin/bash
list=$(<pdbs.list)
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
    file_bfmod=bfmod_${file}
    file_nonmis_bfmod=nonmis_bfmod_${file}
################################
################################

#    mkdir $file
#    cp ../gram/$file/$file_mods $file
#    cp ../gram/$file/*ord $file

    refile_ord=1M14_A_${file}_ord    
    ./enew_pond.exe $refile_ord $file_fre:q aa_pocket 825 $file_bfmod 


done
