#!/bin/bash

#SBATCH --job-name=download
#SBATCH --time=12:00:00
#SBATCH --mem=4G
#SBATCH --output=../logs/download_%j.out

# path to the  folder where links2dowload.txt is

cd ../data

#donwload fastq files the from E folder

#wget -N -i links2download.txt

#Downloading the reference genome for S.C

wget http://sgd-archive.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz
