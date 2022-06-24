#!/bin/bash

dataset=Vitis_vinifera_Liang2019
cd $dataset
mkdir SRA
prefetch -vp -O SRA/ --option-file SRR_Acc_List.txt
mkdir fastq
cd SRA
while IFS= read -r SRR;
do
    echo $SRR
    fasterq-dump --split-files -O ../fastq $SRR
done < ../SRR_Acc_List.txt
for f in *.fastq; do
   echo "$f"
   bgzip "$f"
done
cd ..
rm -r fasterq.tmp.*

mkdir genome
cd genome
# Jaillon, O. et al. The grapevine genome sequence suggests ancestral
# hexaploidization in major angiosperm phyla. Nature 449, 463–467 (2007)
# GCF_000003745.3
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/GCF_000003745.3_12X_genomic.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/GCF_000003745.3_12X_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/README_Vitis_vinifera_annotation_release_102
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/README.txt
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/GCF_000003745.3_12X_assembly_report.txt
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/003/745/GCF_000003745.3_12X/GCF_000003745.3_12X_assembly_stats.txt
cd ..


mkdir metadata
cd metadata
wget https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-019-09135-8/MediaObjects/41467_2019_9135_MOESM4_ESM.xlsx
wget https://static-content.springer.com/esm/art%3A10.1038%2Fs41467-019-09135-8/MediaObjects/41467_2019_9135_MOESM5_ESM.xlsx
wget https://www.nature.com/articles/s41467-019-09135-8.pdf
cd ..


