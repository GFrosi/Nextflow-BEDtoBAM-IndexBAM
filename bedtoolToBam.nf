#!/usr/bin/env nextflow

fileSample = Channel.fromPath('samples.txt')
                    .splitText()
                    .map{ sample -> tuple(sample.split("/")[-1][0..-5], sample.split("/")[-1].split("_")[0], sample, sample.split("/")[0..-2].join("/")) }
                    // .view()


chromo_size =  params.chromo_size

process unzipBed{

    publishDir "$sampleDir/$outDirName"

    input:
    tuple sampleName, outDirName, path(sample), path(sampleDir)  from fileSample

    output:
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}.bed") into unzipbedout
    
    """
        zcat  ${sample} >${sampleName}.bed
    """
}

process bedToBam{
    publishDir "$sampleDir/$outDirName"

    module "bedtools/2.27.1"

    input:
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}.bed") from unzipbedout

    output: 
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}.bam") into bedtobamout

    """
        bedToBam -i ${sampleName}.bed -g $chromo_size > ${sampleName}.bam
    """
}

process sortedBam{

    publishDir "$sampleDir/$outDirName"

    module "samtools/1.5"

    input:
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}.bam") from bedtobamout

    output:
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}_sort.bam") into sortbamout

    """
        samtools sort ${sampleName}.bam -o ${sampleName}_sort.bam
    """

}

process indexBam{

    publishDir "$sampleDir/$outDirName"

    module "samtools/1.5"

    input:
    tuple sampleName, outDirName, path(sampleDir), path("${sampleName}_sort.bam") from sortbamout

    output: 

    path("${sampleName}_sort.bam.bai")

    """
        samtools index ${sampleName}_sort.bam ${sampleName}_sort.bam.bai
    """

}
