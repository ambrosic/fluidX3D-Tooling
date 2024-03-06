#!/bin/bash
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=16 --mem=32G 
#SBATCH --time=1:00:00

# Wrote this because I didn't want to spend any more time manually running FFmpeg commands
# also planning on using this software for a long time, so the better I make the tooling, the easier life gets

# recursively goes through /bin/export and for every subfolder makes an mp4
# then moves that folder to a videoOutput folder

# I might need to consider using FFmpeg to compress the videos at some point, but meh


# VARIABLES FOR SETUP
# this one's for testing locally
#BASEDIR="$PWD"
BASEDIR="$HOME/ambrosic/FluidX3D"
printf "PWD's Working Directory: ${PWD}\nBASEDIR:${BASEDIR}"
# make sure not to have trailing slashes.
INPUTFOLDER="$BASEDIR/bin/export"
OUTFOLDERNAME="videoOutput"
# everything below here shouldn't need tweaks...
DIVIDER="=========================="
# use date as a identifier so you don't have to rename all your mp4s all the time

date=$(date '+%Y-%m-%d_%H_%M_%S')
echo $date
OUTPUTFOLDER="$BASEDIR/$OUTFOLDERNAME/$date"
# echo $OUTPUTFOLDER
mkdir -p "${OUTPUTFOLDER}"
printf "\nRECURSIVE SUBDIR IN FOLDER: ${INPUTFOLDER} \nWITH OUTPUT TO:             ${OUTPUTFOLDER} \n$DIVIDER\nFolders to target:\n"
cd $INPUTFOLDER
# print folders
# find . -maxdepth 1 -mindepth 1 -type d -printf '%P\n'
printf "GENERATING MP4 FILES \n$DIVIDER\n"
for D in $(find ${INPUTFOLDER} -maxdepth 1 -mindepth 1 -type d -printf '%P\n'); do
    echo "$DIVIDER"
    echo "starting ${INPUTFOLDER}/${D}"
    # cd "${INPUTFOLDER}/${D}"
    # ls "${INPUTFOLDER}/${D}/" | grep ".png"
    echo "${INPUTFOLDER}/${D}/*.png ${OUTPUTFOLDER}/${D}.mp4"
    ffmpeg -hide_banner -loglevel error -framerate 30 -pattern_type glob -i "${INPUTFOLDER}/${D}/*.png" -c:v libx264 -pix_fmt yuv420p "${OUTPUTFOLDER}/${D}.mp4"
    # echo "${D}.mp4 complete, moving file to output directory"
    # echo "moving ${D}"
    # mv "$INPUTFOLDER/${D}/${D}.mp4" "$OUTPUTFOLDER/${D}.mp4"
    # echo "file moved"
done
echo "$DIVIDER"
# go back to base CWD
cd $BASEDIR

# rename export folder so it's out of the way for the next job.
# theoretically I could do this at the end of the CFD job?
# mv "${INPUTFOLDER}" "${INPUTFOLDER}-${DATE}"
# make moving happen in its own step
# man am I thankful for stackOverflow
# printf "$DIVIDER\nMOVING MP4 FILES\n"
# eval lets you use environment and piped variables together, which is a necessity for this

# stuff for running in parallel
# find "$INPUTFOLDER/" -maxdepth 1 -mindepth 1 -type d -printf '%P\n' | eval "parallel --jobs 8 'mv $INPUTFOLDER/{}/{}.mp4 $OUTPUTFOLDER/{}.mp4'"
printf "COMPLETE 🤩\n"
#theoretical next step: delete original images