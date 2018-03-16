#! /bin/bash

#SBATCH --job-name=pred_im
#SBATCH --partition=common
#SBATCH --ntasks=1
#SBATCH --error="pred_im.out"
#SBATCH --output="pred_im.out"

list=$1
lista=$(<im.list)
i=0

for file in $list
do
    echo -------- $file -------  
    
    i=`expr $i + 1`

# Nombres de input
    nonrot_pdb=nonrot_$file.pdb
    pdb=$file.pdb
    file_dis=${file}_dis
    file_hb2=${file}.hb2
    hb_file=hb_${file}
    cutoff_a=9
# Nombres de output de 'epanmhs.exe'
    file_bf=bf_${file}
    file_bfcorr=bfcorr_${file}
    file_bfteo=bfteo_${file}
    file_colec=colec_${file}
    file_correl=correl_${file}
    file_freq=freq_${file}
    file_mods=modos_${file}

    file_bfmod=bfmod_${file}
################################
################################
    cd $file

    for refile in $lista
    do
        if [[ $file == $refile ]] 
        then
            continue
        fi
        echo $refile

        refile_mods=modos_${refile}
        refile_freq=freq_${refile}

        refile_ord=${file}_${refile}_ord
        refile_fqord=${file}_${refile}_fqord
        refile_nsub=${file}_${refile}_nsub
        refile_bfmod=${file}_${refile}_bfmod

        refile_zeta=zeta_${file}_${refile}
        refile_nd=nd_${file}_${refile}
        refile_val=val_${file}_${refile}
        refile_vec=vec_${file}_${refile}

        ./esort_fq_old.exe $refile_freq $refile_nsub 825 $refile_fqord

        ./eold_bipond.exe $file_mods $file_freq $refile_ord $refile_fqord nonmis_aa_pocket none none 825 825 dummy dummy $file_bfmod $refile_bfmod

        ./eold_bigram.exe $file_mods $refile_ord $file_bfmod $refile_bfmod 825 825 825 $refile_zeta $refile_nd $refile_val $refile_vec
    done

    cd ..
done
