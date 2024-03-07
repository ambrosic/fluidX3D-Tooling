import json
from enum import Enum
from git import Repo
import subprocess
import os

# requires the gitPython library, if not installed, run ``pip install gitpython``.


configRaw = open('config.json')

config = json.load(configRaw)

target = config['targetPlatform']

baseFolder = "temp/test"

# for case switching on stuff that's platform dependent
class platform(Enum):
    LOCAL="LOCAL"
    BEOSHOCK="BEOSHOCK"
    GENERIC_HPC="GENERIC_HPC"


print(target)
print(platform.LOCAL.value)

if(target == platform.LOCAL.value):
    print(config['postprocessor'])


# I'll be writing these steps as if for BeoShock and not anything else for starters.
# once this script is capable of running on beoShock, we'll go from there.

# STEP ONE: CLONE THE REPOSITORY
def clone_or_checkout_repository(repo_url, local_folder, branch='master'):
    try:
        # Attempt to open the repository (checks if it exists)
        repo = Repo(local_folder)
        print(f"Repository found at {local_folder}")
    except:
        # If the repository doesn't exist, clone it
        repo = Repo.clone_from(repo_url, local_folder, branch=branch)
        print(f"Cloned repository from {repo_url} to {local_folder}")

    # Checkout the specified branch
    repo.git.checkout(branch)
    print(f"Checked out branch: {branch}")

# Example usage:
# repo_url = 'https://github.com/user/project.git'
# local_folder = '/home/antro/Project'
# branch_to_clone = 'development'  # Specify the branch you want to clone
# print(config['repository']['url'],config['repository']['branch'])

clone_or_checkout_repository(config['repository']['url'],baseFolder , config['repository']['branch'])

# subprocess.run(["chmod","u+x /bin/temp/make.sh"])

if(target == platform.BEOSHOCK.value):
    print("Running Beoshock Make Command")
    subprocess.run(["sbatch","--parsable temp/fx3d/make.sh"])
elif(target == platform.LOCAL.value):
    print("RUNNING ON LOCAL PLATFORM")
    # subprocess.run(["temp/test/make.sh"])

# test = subprocess.run(["Write-Host","hi"])
test1 = subprocess.run(['wsl',"chmod u+x temp/test/make.sh"],cwd=os.getcwd())
test3 = subprocess.run(['wsl','ls'])
test2 = subprocess.run(['wsl',"temp/test/make.sh"])
test2.args
print("completed testing")