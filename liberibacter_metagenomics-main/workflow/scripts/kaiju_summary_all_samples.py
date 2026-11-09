import pandas as pd
from pathlib import Path
from sys import argv


def list_tsv_files(directory):
    """
    Returns a list of all .tsv files in the specified directory.

    Args:
        directory (str | Path): The path to the directory to search.

    Returns:
        List[Path]: A list of Paths to .tsv files.
    """
    directory = Path(directory)
    return list(directory.glob('*.tsv'))


def create_otu_df(tsv_list):
    merged_df = pd.DataFrame()
    for file in tsv_list:
        sample_id = file.name.split("_results.tsv")[0]
        df = pd.read_csv(file, sep='\t', usecols=["taxon_id", "reads","taxon_name"], dtype={"taxon_id":str})

        df.loc[df["taxon_id"].isna() & (df["taxon_name"] == "unclassified"), "taxon_id"] = "unclassified"
        df.drop("taxon_name", axis=1, inplace=True)
        df.dropna(inplace=True)
        df["reads"] = df["reads"].astype(int)
        df = df.rename(columns={"reads": sample_id}).set_index("taxon_id")
        if merged_df.empty:
            merged_df = df
        else:
            merged_df = pd.concat([merged_df, df], axis=1, join="outer")  # Merge on taxon_id
    final_df = merged_df.fillna(0).astype(int)
    return final_df



input_directory = argv[1]
output_path = argv[2]



kaiju_list = list_tsv_files(input_directory)
otu_df = create_otu_df(kaiju_list)
otu_df.to_csv(output_path, sep="\t")





