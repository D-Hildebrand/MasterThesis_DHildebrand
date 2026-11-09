from pathlib import Path
configfile: "config/config.yaml"

# Sample list builder, if you have a different directory structure, you can adjust this code
samples_dir = config['samples_dir']
if config ['sample_dir_structure'] == "nested":
    SAMPLES = [s.name for s in Path(samples_dir).iterdir() if s.is_dir()]
elif config ['sample_dir_structure'] == "single":
    SAMPLES = list(set([s.name.split(".")[0].split("_")[0] for s in Path(samples_dir).iterdir()]))
else:
    print("Invalid directory structure entered in config file, please only use 'single' or 'nested'")
    quit()

# Load form config
HOST_GENOME=config['bwa_index']['genome']
HOST_GENOME_NAME=Path(HOST_GENOME).stem

SUFFIX=config['suffix_samples']