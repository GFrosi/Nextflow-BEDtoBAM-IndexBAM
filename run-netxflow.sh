#!/bin/bash
#SBATCH --time=12:00:00
#SBATCH --account=
#SBATCH --cpus-per-task=4
#SBATCH --mem=5G
#SBATCH --job-name=nextflow

module load nextflow/20.04.1 python/3.7.4

nextflow run bedtoolToBam.nf -c nextflow.config -with-report report_nextflow 
