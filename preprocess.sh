#!/bin/bash
#SBATCH --parsable --nodes=1 --ntasks=1 --cpus-per-task=4 --mem=4G 
#SBATCH --time=10:00

# this job shouldn't take that long at all.

BASEDIR="$HOME/ambrosic/FluidX3D"

#cd "${BASEDIR}/bin/export"
#rm -rf

echo "EVENTUAL HOME FOR SETUP STUFF, LIKE DELETING THE CONTENTS OF /BIN/EXPORT"
