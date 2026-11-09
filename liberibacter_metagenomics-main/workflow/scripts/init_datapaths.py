import os
import yaml

# Define the path to the config.yaml file
config_path = os.path.join(os.path.dirname(__file__), '../../config/config.yaml')

# Read the config.yaml file to get the data_storage_path
with open(config_path, 'r') as file:
    config = yaml.safe_load(file)

# Get the data_storage_path from the config
data_storage_path = config.get('data_storage_path', '')

# Expand the ~ (user home directory) to the full absolute path
data_storage_path = os.path.expanduser(data_storage_path)

# Define the target directory where the symbolic link should be created
resources_path = os.path.join(os.path.dirname(__file__), '../../resources')

# Ensure the resources directory exists
os.makedirs(resources_path, exist_ok=True)

# Define the symlink path
symlink_path = os.path.join(resources_path, 'data')

# Create the symbolic link if it does not exist
if not os.path.exists(symlink_path):
    os.symlink(data_storage_path, symlink_path)
    print(f"Created symlink: {symlink_path} -> {data_storage_path}")
else:
    print(f"Symlink already exists: {symlink_path}")
