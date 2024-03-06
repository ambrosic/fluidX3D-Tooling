#!/bin/bash

# make all scripts executable, in case they weren't because of git:
script1="preprocess.sh"
script2="dummyMake.sh"
script3="postprocess_remote.sh"

scripts=(script1 script2 script3)

for element in "${scripts[@]}"
do
    echo "${element}"
    chmod u+x "${element}"
done

# clean up working directory
task1=$(sbatch --parsable "${script1}")

task2=$(sbatch --parsable --dependency=aftercorr:${task1} "${script2}")

task3=$(sbatch --parsable --dependency=aftercorr:${task2} "${script3}")

jobids=(task1 task2 task3)

echo "scheduling completed."

for i in $(seq 1 ${#jobids[@]})
do
    echo "script: ${scripts[i]} has jobid: ${jobids[i]}"
done
