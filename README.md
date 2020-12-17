# Nextflow-BEDtoBAM-IndexBAM

A short pipeline to generated the sorted BAM files and their index files (bam.bai)


<<<<<<< HEAD
## Setup
=======
##Setup
>>>>>>> 8accd7c6f87d6fa2571d8dfcb2930a2ca58e1d15

The bedtoolToBam.nf pipeline receives a list of samples (path to each sample, in this case just one). This sample will be unziped and stored in a new BED file. The BED file will be converted in a BAM file, and this last one will be sorted (sorted.BAM). The sorted.BAM file will be used to generate the BAM.bai file for our sample.


The nextflow.config was designed to run the pipeline using the SLURM. You should adjust this file with the path to hg38.chrom.size (this file is available in this repository) and add your account to run via SLURM.


```
chromo_size = /PATH/TO/hg38.chrom.size
clusterOptions = '--account= ADD_YOUR_ACCOUNT

``` 

<<<<<<< HEAD
## Usage
=======
##Usage
>>>>>>> 8accd7c6f87d6fa2571d8dfcb2930a2ca58e1d15

You should to adjust the run-nextflow.sh with your account and check the command. To run the .sh file you just do:

```
sbatch run-netxflow.sh

```

The command line to be run is:

```
nextflow run bedtoolToBam.nf -c nextflow.config -with-report report_nextflow
``` 

You can change the report name (in this case report_nextflow) and add the paths to the pipeline and config file. 
