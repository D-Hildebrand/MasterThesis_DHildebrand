configfile: "config/config.yaml"


rule samtools_flagstat:
    input:
        "resources/mapped_reads/{sample}.bam",
    output:
        "results/mapping_stats/{sample}.tsv",
    params:
        extra=config['flagstat']['extra'],  # optional params string
    threads: config['flagstat']['threads']
    wrapper:
        "v5.5.0/bio/samtools/flagstat"

# Extract the paired reads that BOTH did not align
rule samtools_view:
    input:
        "resources/mapped_reads/{sample}.bam"
    output:
        "resources/nonhost_reads/{sample}_nonhost.bam"
    params:
        extra=config['view']['extra'],  # extra params, in this case -f 12 to make sure that the pair both did not allign.
    threads:
        config['view']['threads']
    wrapper:
        "v5.5.0/bio/samtools/view"


rule samtools_fastq_separate:
    # Convert a bam file with paired end reads back to unaligned reads in a two separate fastq files with samtools.
    # Reads that are not properly paired are discarded (READ_OTHER and singleton reads in samtools fastq documentation),
    # as are secondary (0x100) and supplementary reads (0x800).
    input:
        "resources/nonhost_reads/{sample}_nonhost.bam",
    output:
        "resources/nonhost_reads/{sample}_1." + SUFFIX,
        "resources/nonhost_reads/{sample}_2." + SUFFIX,
    log:
        "{sample}.separate.log",
    params:
        collate=config['separate']['collate'],
        fastq=config['separate']['fastq'],
    # Remember, this is the number of samtools' additional threads.
    # At least 2 threads have to be requested on cluster sumbission.
    # This value - 2 will be sent to samtools sort -@ argument.
    threads: config['separate']['threads']
    wrapper:
        "v5.5.0/bio/samtools/fastq/separate"
