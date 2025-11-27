#!/bin/bash

#SBATCH --job-name=multiqc
#SBATCH --output=../logs/multiqc_%j.out
#SBATCH --error=../logs/multiqc_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=4G

module load py-multiqc/1.15-gcc-13.2.0-python-3.11.6

# Running MultiQC on the FastQC output directory
multiqc ../results/ -o ../results/multiqc_out
