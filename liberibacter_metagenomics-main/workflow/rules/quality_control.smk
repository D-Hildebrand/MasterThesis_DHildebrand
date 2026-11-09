rule fastp_pe:
# Run fast_pe to trim low quality reads, and potentially remove adapters (were not present)
    input:
        sample=[
            config['samples_dir'] + "{sample}/{sample}_1." + SUFFIX,
            config['samples_dir'] + "{sample}/{sample}_2." + SUFFIX        ]
    output:
        trimmed=[
            "resources/trimmed_reads/{sample}_1." + SUFFIX,
            "resources/trimmed_reads/{sample}_2." + SUFFIX
        ],
        failed="resources/trimmed_reads/{sample}.failed." + SUFFIX,
        json="results/fastp/{sample}.json",
        html="results/fastp/{sample}.html"

    threads: config['fastp_pe']['threads']
    wrapper:
        "v5.8.2/bio/fastp"
