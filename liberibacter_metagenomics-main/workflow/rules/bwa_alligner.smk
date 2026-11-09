configfile: "config/config.yaml"
include: "globals.smk" # for sample list building


rule bwa_index:
# Index the host genome for aligning the shotgun reads
    input:
        HOST_GENOME
    output:
        idx=multiext(f"resources/genome_indexes/{HOST_GENOME_NAME}", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        f"logs/bwa_index/{HOST_GENOME_NAME}.log",
    params:
        extra = "-a " + config['bwa_index']['alg']
    threads: config['bwa_index']['threads']
    wrapper:
        "v5.8.2/bio/bwa/index"


rule bwa_mem:
# Allign the trimmed reads to a genome of choice (In this case combined citrus genomes)
    input:
        reads=[
            "resources/trimmed_reads/{sample}_1." + SUFFIX,
            "resources/trimmed_reads/{sample}_2." + SUFFIX
        ],
        idx=multiext(f"resources/genome_indexes/{HOST_GENOME_NAME}",
            ".amb", ".ann", ".bwt", ".pac", ".sa"),
    output:
        "resources/mapped_reads/{sample}.bam",
    log:
        "logs/bwa_mem/{sample}.log",
    params:
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sorting=config['bwa_mem']['sorting'],
        sort_order=config['bwa_mem']['sort_order'],
        sort_extra=config['bwa_mem']['sort_extra'],
    threads: config['bwa_mem']['threads'],
    wrapper:
        "v5.5.0/bio/bwa/mem"