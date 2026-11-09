configfile: "config/config.yaml"


rule summarize_kaiju_tables:
    input:
        tables=expand("results/kaiju/tsv/{sample}_results.tsv", sample=SAMPLES)
    output:
        table=temp("results/summary_kaiju/all_samples_summary.tsv")
    params:
        kaiju_output_dir="results/kaiju/tsv"
    conda:
        "../envs/python.yaml"
    shell:
        "python3 workflow/scripts/kaiju_summary_all_samples.py {params.kaiju_output_dir} {output}"


rule add_taxonomy_kaiju_summary:
    input:
        "results/summary_kaiju/all_samples_summary.tsv"
    output:
        temp("results/summary_kaiju/w_taxon_all_samples_summary.tsv")
    params:
        columns= lambda wc: "{p}\t{c}\t{o}\t{f}\t{g}\t{s}"
    conda:
        "../envs/taxonkit.yaml"
    shell:
        "cat {input} | ./workflow/scripts/add_taxonomy.sh > {output}"

rule add_columns_names:
    input:
        "results/summary_kaiju/w_taxon_all_samples_summary.tsv"
    output:
        "results/summary_kaiju/kaiju_summary_complete.tsv"
    shell:
        "./workflow/scripts/add_col_names.sh {input} -o {output}"