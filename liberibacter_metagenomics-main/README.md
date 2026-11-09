# Snakemake workflow: `Candidatus Liberibacter asiaticus co-occurence analysis`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow for `Analysing the occurence of bacteria from metagenomic samples`.
This pipeline is capable of filtering reads, removing host DNA, Classifying reads and visualising the sample composition.


## Usage
Clone the repository. Do this on a location with sufficient storage space, as intermediate and final files will be stored alongside the pipleine, which can take up significant disk space depeding on your setup.

Download reference genome of host organism and specify its location in the configfile located in config/config.yaml. This will be used
filter out host DNA that is present in the samples.

Specify the location of the samples. The structure that this pipeline expects is a bit specific. If you want to get it running immideately without tinkering, I recommend using this structure:

```
.
└── resources/
    └── samples/
        ├── sample1/
        │   ├── sample1_1.fq
        │   └── sample1_2.fq  
        ├── sample2/
        │   ├── sample2_1.fq
        │   └── sample2_2.fq
        └── sample3/
            ├── sample3_1.fq
            └── sample3_2.fq
```

.fq .fastq .fq.gz and .fastq.gz are supported formats for the reads of the metagenomic samples

Set up the config file with your own parameters.

Run the pipeline with `snakemake --use-conda -c <core-num>`, make sure that snakemake is activated in your current conda environment!
Using screen as well as nice is recommended.



The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=<owner>%2F<repo>).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).

# TODO

* Replace `<owner>` and `<repo>` everywhere in the template (also under .github/workflows) with the correct `<repo>` name and owning user or organization.
* Replace `<name>` with the workflow name (can be the same as `<repo>`).
* Replace `<description>` with a description of what the workflow does.
* The workflow will occur in the snakemake-workflow-catalog once it has been made public. Then the link under "Usage" will point to the usage instructions if `<owner>` and `<repo>` were correctly set.