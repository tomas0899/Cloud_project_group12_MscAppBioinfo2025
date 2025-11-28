This project reproduces the computational analysis from the paper
“Ribosome profiling analysis of eEF3-depleted Saccharomyces cerevisiae” (Kasari et al., 2019).
The goal is to reconstruct the authors’ Ribo-Seq processing workflow — including trimming, filtering, alignment, P-site assignment, and codon occupancy analysis — using the publicly available dataset E-MTAB-6938 and the Python-based tool RiboSeqPy.

To ensure reproducibility, all analyses are executed in a dedicated conda environment containing software versions compatible with the original pipeline. The workflow is run on a high-performance computing (HPC) cluster using SLURM, and scripts are provided for environment setup, data download, preprocessing, and running RiboSeqPy



# RNA-seq & Ribo-seq Processing Pipeline

This repository contains a modular HPC workflow for processing Saccharomyces cerevisiae RNA-seq and Ribo-seq data. Each analysis step is run through an individual `sbatch` script, allowing flexibility and easy troubleshooting. The pipeline currently includes:

1. Downloading raw data & reference genome
2. Quality control with FastQC
3. Aggregated reporting using MultiQC

## Project Overview

This project reproduces the computational workflow from the paper:
**“Ribosome profiling analysis of eEF3-depleted Saccharomyces cerevisiae”** (Kasari et al., 2019).

The goal is to reconstruct the authors’ Ribo-Seq processing pipeline, including:

* Trimming and filtering reads
* Alignment to the reference genome
* P-site assignment
* Codon occupancy analysis

All analyses are executed in a dedicated conda environment to ensure reproducibility, using software versions compatible with the original study.

## 1. Conda Environment Setup

Environment name: `copyeEF3`

**Setup commands:**

```bash
conda create --name copyeEF3 python=3.5
conda activate copyeEF3
conda config --add channels bioconda
conda config --add channels conda-forge
```

**Installed tools and versions:**

| Tool     | Version  |
| -------- | -------- |
| wget     | 1.21.4   |
| cutadapt | 1.15     |
| samtools | 1.5      |
| HISAT2   | 2.2.1    |
| bowtie2  | 2.5.4    |
| FastQC   | 0.12.1   |
| pysam    | 0.11.2.2 |

> Note: MultiQC is loaded via an HPC module to ensure compatibility.

## 2. Data Download

Raw sequencing data (FASTQ) and the S. cerevisiae reference genome are downloaded via `scripts/01_download_data.sh`.

**Run command:**

```bash
sbatch scripts/01_download_data.sh
```

**Outputs:**

```
data/raw/rna/
data/raw/ribo/
data/reference/
```

## 3. Quality Control (FastQC)

FastQC is run separately on RNA and Ribo sequencing files using `scripts/02_fastqc.sh`.

**Run command:**

```bash
sbatch scripts/02_fastqc.sh
```

**Outputs:**

```
results/rna/
results/ribo/
```

## 4. MultiQC Summary Report

Aggregates all FastQC outputs into a single report using `scripts/03_multiqc.sh`.

**Run command:**

```bash
sbatch scripts/03_multiqc.sh
```

**Outputs:**

```
results/multiqc_out/multiqc_report.html
results/multiqc_out/multiqc_data/
```

## 5. Project Folder Structure

```
project/
├── data/
│   ├── raw/
│   │   ├── rna/
│   │   └── ribo/
│   └── reference/
├── results/
│   ├── rna/
│   ├── ribo/
│   └── multiqc_out/
├── logs/
└── scripts/
    ├── 01_download_data.sh
    ├── 02_fastqc.sh
    └── 03_multiqc.sh
```

## 6. Next Steps (planned)

* Adapter trimming (Cutadapt)
* rRNA depletion
* Alignment (HISAT2/Bowtie2)
* BAM sorting (Samtools)
* P-site assignment and codon occupancy analysis
* FeatureCounts or RiboToolkit analysis

Each step will have a dedicated SLURM script to ensure reproducibility and traceability.

