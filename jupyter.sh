#!/bin/bash -l

#SBATCH --job-name=ops-jupyter
#SBATCH --partition=msc_appbio
#SBATCH --ntasks=1
#SBATCH --mem=10G
#SBATCH --signal=USR2
#SBATCH --cpus-per-task=1
#SBATCH --time 0-03:00
cd /scratch/grp/msc_appbio/Group12_ABCC/github_repo/Cloud_project_group12_MscAppBioinfo2025

module load copyeEF3 
conda init

# get unused socket per https://unix.stackexchange.com/a/132524
readonly IPADDRESS=$(hostname -I | tr ' ' '\n' | grep '10.211.4.')
readonly PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   Linux and MacOS:
   ssh -NL 8888:${HOSTNAME}:${PORT} ${USER}@hpc.create.kcl.ac.uk

   Windows:
   ssh -m hmac-sha2-512 -NL 8888:${HOSTNAME}:${PORT} ${USER}@hpc.create.kcl.ac.uk

   and point your web browser to http://localhost:8888/lab?token=<add the token from the jupyter output below>

When done using the notebook, terminate the job by
issuing the following command on the login node:

      scancel -f ${SLURM_JOB_ID}

END

conda activate copyeEF3
jupyter-lab --port=${PORT} --ip=${IPADDRESS} --no-browser

printf 'notebook exited' 1>&2
