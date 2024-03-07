# Notes and Documentation Links

I hate reinventing the wheel & looking for the same information twice...

## BeoShock Docs

- General overview
  - <https://www.wichita.edu/services/hpc/hpc-guides.php>
- Wiki - requires school VPN or physical presence on network :/
  - Main Page: <https://docs.hpc.wichita.edu/index.php?title=Main_Page>
  - Slurm Basics: <https://docs.hpc.wichita.edu/index.php?title=SlurmBasics>
  - Advanced Slurm: <https://docs.hpc.wichita.edu/index.php?title=AdvancedSlurm>
  - Compute Nodes: <https://docs.hpc.wichita.edu/index.php?title=Compute_Nodes>
    - Spoiler: not much
    - Good news?  CPU heterogeneity- all Xeon Gold 6240 CPU's.
    - ![two GPU nodes, two high memory nodes, and 16 compute nodes](docs/wsuComputeResources.png)

### Python on BeoShock

- create a folder for virtual environments:
   - ``mkdir ~/virtualenvs``
 - create a virtual environment:
  - ``cd ~/virtualenvs``
  - ``virtualenv test``
- Now you can install modules and the like.
- Once you log off, your virtual environment will be discarded, so load it by running:
  - ``source ~/virtualenvs/test/bin/activate``
- or, alternatively, make a bash script that loads your environment and your scheduler that you wrote in python to get away from ``jq`` and that you were hoping would be the be-all end-all of your programming scripts.  Ack.
- this might also be useful:
  - <https://www.geeksforgeeks.org/how-to-automatically-install-required-packages-from-a-python-script/>