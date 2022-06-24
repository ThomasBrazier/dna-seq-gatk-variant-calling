# Snakemake workflow: dna-seq-gatk-variant-calling

[![DOI](https://zenodo.org/badge/139045164.svg)](https://zenodo.org/badge/latestdoi/139045164)
[![Snakemake](https://img.shields.io/badge/snakemake-≥6.1.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/snakemake-workflows/dna-seq-gatk-variant-calling/workflows/Tests/badge.svg?branch=main)](https://github.com/snakemake-workflows/dna-seq-gatk-variant-calling/actions?query=branch%3Amain+workflow%3ATests)

This Snakemake pipeline implements the [GATK best-practices workflow](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels-) for calling small germline variants.

## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=snakemake-workflows%2Fdna-seq-gatk-variant-calling).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).


## Install Snakemake and Snakedeploy

 Snakemake and Snakedeploy are best installed via the Mamba package manager (a drop-in replacement for conda). If you have neither Conda nor Mamba, it can be installed via Mambaforge. For other options see here.

Given that Mamba is installed, run

mamba create -c bioconda -c conda-forge --name snakemake snakemake snakedeploy

to install both Snakemake and Snakedeploy in an isolated environment. For all following commands ensure that this environment is activated via

conda activate snakemake

## Deploy workflow 

 Given that Snakemake and Snakedeploy are installed and available (see Step 1), the workflow can be deployed as follows.

First, create an appropriate project working directory on your system and enter it:

```
mkdir -p path/to/project-workdir
cd path/to/project-workdir
```

In all following steps, we will assume that you are inside of that directory.

Second, run

`snakedeploy deploy-workflow https://github.com/snakemake-workflows/dna-seq-gatk-variant-calling . --tag v2.1.1`

Snakedeploy will create two folders workflow and config. The former contains the deployment of the chosen workflow as a Snakemake module, the latter contains configuration files which will be modified in the next step in order to configure the workflow to your needs. Later, when executing the workflow, Snakemake will automatically find the main Snakefile in the workflow subfolder.

Third, consider to put this directory under version control, e.g. by managing it via a (private) Github repository

## Configure workflow

### General settings

To configure this workflow, modify config/config.yaml according to your needs, following the explanations provided in the file.

### Sample and unit sheet

Add samples to config/samples.tsv. Only the column sample is mandatory, but any additional columns can be added. For each sample, add one or more sequencing units (runs, lanes or replicates) to the unit sheet config/units.tsv. For each unit, define platform, and either one (column fq1) or two (columns fq1, fq2) FASTQ files (these can point to anywhere in your system).

The pipeline will jointly call all samples that are defined, following the GATK best practices.

## Run workflow

Given that the workflow has been properly deployed and configured, it can be executed as follows.

Fow running the workflow while deploying any necessary software via conda (using the Mamba package manager by default), run Snakemake with

`snakemake --cores all --use-conda`

Snakemake will automatically detect the main Snakefile in the workflow subfolder and execute the workflow module that has been defined by the deployment in step 2.

For further options, e.g. for cluster and cloud execution, see the docs.

## Generate report

After finalizing your data analysis, you can automatically generate an interactive visual HTML report for inspection of results together with parameters and code inside of the browser via

`snakemake --report report.zip`

The resulting report.zip file can be passed on to collaborators, provided as a supplementary file in publications, or uploaded to a service like Zenodo in order to obtain a citable DOI. 
