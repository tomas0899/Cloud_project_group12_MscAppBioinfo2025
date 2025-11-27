#!/bin/bash

#SBATCH --job-name=fastqc_rna_ribo
#SBATCH --output=../logs/fastqc_%j.out
#SBATCH --error=../logs/fastqc_%j.err
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --mem=4G

#load anaconda and activate environment

module load anaconda3/2022.10-gcc-13.2.0
eval "$(conda shell.bash hook)"
conda activate copyeEF3

#Base directories
base_input=../data/raw
base_output=../results

#loop over ribo and rna
for type in ribo rna; do
    input_dir=${base_input}/${type}
    output_dir=${base_output}/${type}

    #running fastqc over each fastq file
    for fq in ${input_dir}/*.fastq.gz; do
        echo "processing $fq ..."
        fastqc "$fq" -o ${output_dir} -t 4
    done
done

