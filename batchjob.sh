#!/bin/bash
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem=12G --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --parsable

# Platform variation fixing:
platform=$1

if [[ "${platform}" = "BEOSHOCK" ]]; then
    printf "loading modules"
    module load foss/2022a CUDA/11.7.0
elif [[ "${platform}" = "GENERIC_HPC" ]]; then
    printf "BATCHJOB: GENERIC LINUX"
elif [[ "${platform}" = "WINDOWS" ]]; then
    printf "TARGET PLATFORM: WINDOWS.  UNTESTED!"
fi


# goals: get a GPU run


date=$(date '+%Y-%m-%d_%H_%M_%S')
DIVIDER="=============="
# node information
NODEINFO=("CUDA_VISIBLE_DEVICES ${CUDA_VISIBLE_DEVICES}\n \
GPU_DEVICE_ORDINAL ${GPU_DEVICE_ORDINAL}\n \
HOSTNAME ${HOSTNAME}\n \
SLURMD_NODENAME ${SLURMD_NODENAME}\n \
SLURM_CHECKPOINT_IMAGE_DIR ${SLURM_CHECKPOINT_IMAGE_DIR}\n \
SLURM_CLUSTER_NAME ${SLURM_CLUSTER_NAME}\n \
SLURM_CPUS_ON_NODE ${SLURM_CPUS_ON_NODE}\n \
SLURM_GTIDS ${SLURM_GTIDS}\n \
SLURM_JOBID ${SLURM_JOBID}\n \
SLURM_JOB_ACCOUNT ${SLURM_JOB_ACCOUNT}\n \
SLURM_JOB_CPUS_PER_NODE ${SLURM_JOB_CPUS_PER_NODE}\n \
SLURM_JOB_GID ${SLURM_JOB_GID}\n \
SLURM_JOB_GPUS ${SLURM_JOB_GPUS}\n \
SLURM_JOB_ID ${SLURM_JOB_ID}\n \
SLURM_JOB_NAME ${SLURM_JOB_NAME}\n \
SLURM_JOB_NODELIST ${SLURM_JOB_NODELIST}\n \
SLURM_JOB_NUM_NODES ${SLURM_JOB_NUM_NODES}\n \
SLURM_JOB_PARTITION ${SLURM_JOB_PARTITION}\n \
SLURM_JOB_QOS ${SLURM_JOB_QOS}\n \
SLURM_JOB_UID ${SLURM_JOB_UID}\n \
SLURM_JOB_USER ${SLURM_JOB_USER}\n \
SLURM_LOCALID ${SLURM_LOCALID}\n \
SLURM_MEM_PER_NODE ${SLURM_MEM_PER_NODE}\n \
SLURM_NNODES ${SLURM_NNODES}\n \
SLURM_NODEID ${SLURM_NODEID}\n \
SLURM_NODELIST ${SLURM_NODELIST}\n \
SLURM_NODE_ALIASES ${SLURM_NODE_ALIASES}\n \
SLURM_PRIO_PROCESS ${SLURM_PRIO_PROCESS}\n \
SLURM_PROCID ${SLURM_PROCID}\n \
SLURM_SUBMIT_DIR ${SLURM_SUBMIT_DIR}\n \
SLURM_SUBMIT_HOST ${SLURM_SUBMIT_HOST}\n \
SLURM_TASKS_PER_NODE ${SLURM_TASKS_PER_NODE}\n \
SLURM_TASK_PID ${SLURM_TASK_PID}\n \
SLURM_TOPOLOGY_ADDR ${SLURM_TOPOLOGY_ADDR}\n \
SLURM_TOPOLOGY_ADDR_PATTERN ${SLURM_TOPOLOGY_ADDR_PATTERN}\n \
SLURM_WORKING_CLUSTER ${SLURM_WORKING_CLUSTER}\n \
TERM ${TERM}\n \
TMPDIR ${TMPDIR}\n \
USER ${USER}\n")
GPUINFO=(nvidia-smi)

echo "${DIVIDER}"

# echo '$DIVIDER'
#cd "$HOME/github/fluidX3D-Tooling/temp/fx3d"

#source /make.sh > "$HOME/logs/${date}-FLUIDX3D.txt"


#printf "${GPUINFO}\n${DIVIDER}\n${NODEINFO}" > "$HOME/logs/${date}.txt"
# OUTPUT=(source /make.sh)
#printf "${DIVIDER}\n${OUTPUT}\n" > "$HOME/logs/${date}-FLUIDX3D.txt"
#cat "$HOME/logs/${date}.txt"
chmod +x "temp/fx3d/make.sh"
./temp/fx3d/make.sh
