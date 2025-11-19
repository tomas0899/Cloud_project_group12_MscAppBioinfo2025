This project reproduces the computational analysis from the paper
“Ribosome profiling analysis of eEF3-depleted Saccharomyces cerevisiae” (Kasari et al., 2019).
The goal is to reconstruct the authors’ Ribo-Seq processing workflow — including trimming, filtering, alignment, P-site assignment, and codon occupancy analysis — using the publicly available dataset E-MTAB-6938 and the Python-based tool RiboSeqPy.

To ensure reproducibility, all analyses are executed in a dedicated conda environment containing software versions compatible with the original pipeline. The workflow is run on a high-performance computing (HPC) cluster using SLURM, and scripts are provided for environment setup, data download, preprocessing, and running RiboSeqPy



#!/bin/bash
# --------------------------------------------
# Script to setup conda environment and download data
# --------------------------------------------

# --- 1. Create conda environment ---
- conda create --name copyeEF3 python=3.5 
- conda activate copyeEF3
- conda config --add channels bioconda #to use bioinformatic tools
 
# --- 2. Install required tools ---

- conda install wget            #version installed 1.21.4(most recent version) as the old version was not packed for Linux and the main use of it is to download files , in the paper they used 1.18 . ##the instruction provided by the paper were only for mac user
- conda install cutadapt=1.15 
- conda install samtools=1.5 
- conda install hisat2=2.2.1 
- conda install bowtie2          #version installed 2.5.4(newest) there was not specification on the vesion
- conda install fastqc           #version installed 0.12.1(newest) there was not specification on the vesion
- conda install pysam=0.11.2.2 

##bash

# --- 3. Download SDRF file ( Ribo-Seq and RNA-Seq sequencing data from ArrayExpress database at EMBL-EBI accession number E-MTAB-6938)---
wget https://ftp.ebi.ac.uk/biostudies/fire/E-MTAB-/938/E-MTAB-6938/Files/E-MTAB-6938.sdrf.txt

##bash

# --- 4. Extract FASTQ links ---
cat E-MTAB-5515.sdrf.txt | cut -f34 | tail -n +2 > links2download.txt

# --- 5. Download FASTQ files ( done via sbatch job) ---
downloadFasqfiles.slum #that is the script use to downloas the files.

# Downloading the reference genome
 S. cerevisiae reference genome R64-1-1

