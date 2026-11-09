rule kaiju_to_krona:
    input:
        kaiju_out="results/kaiju/txt/{sample}_results.txt"
    output:
        krona=temp("results/kaiju/krona/{sample}.krona")
    params:
        nodes=config['kaiju']['nodes'],
        names=config['kaiju']['names']
    conda:
        "../envs/kaiju.yaml"
    shell:
        """
            kaiju2krona \
            -t {params.nodes} \
            -n {params.names} \
            -i {input.kaiju_out} \
            -o {output.krona}
        """


rule krona_to_html:
    input:
        krona_out="results/kaiju/krona/{sample}.krona"
    output:
        html="results/kaiju/krona/{sample}.html"
    conda:
        "../envs/krona.yaml"
    shell:
        """
            ktImportText \
            {input.krona_out} \
            -o {output.html}
        """