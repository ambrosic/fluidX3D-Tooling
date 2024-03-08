#!/bin/bash
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=16 --mem=32G --parsable
#SBATCH --time=1:00:00

# Unlike the other postprocessing scripts, this one takes arguments and only handles a singular subfolder,
#    for ease of scheduling across multiple systems.
# This one also doesn't create a subfolder per date and expects that to be specified in the function call.
# Nothing in this script *requires* the use of an HPC environment, though- that will be handled through the
#    scheduling script- the only thing that uses an HPC command is ensuring the ffmpeg module is loaded.

# Arguments required:
# 1. input folder path
# 2. output folder path
# 3. output file name

# Environment Variable handling
# make sure not to have trailing slashes.
INPUTFOLDER="$1"
OUTPUTFOLDER="$2"
FILENAME="$3"

# everything below here shouldn't need tweaks...
DIVIDER="=========================="
printf "loading ffmpeg module\n"
module load FFmpeg

mkdir -p "${OUTPUTFOLDER}"
printf "${DIVIDER}\n
Converting images in folder: ${INPUTFOLDER}\n
With output to:             ${OUTPUTFOLDER}\n
Output File Name:           ${FILENAME}\n
$DIVIDER\n"

echo "${INPUTFOLDER}/*.png ${OUTPUTFOLDER}/${FILENAME}.mp4"
ffmpeg -hide_banner -loglevel error -framerate 30 -pattern_type glob -i "${INPUTFOLDER}/*.png" -c:v libx264 -pix_fmt yuv420p "${OUTPUTFOLDER}/${FILENAME}.mp4"

printf "${DIVIDER}\nFFmpeg command completed, exiting."