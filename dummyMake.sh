#!/bin/bash
#/bin/bash
#SBATCH --nodes=1 --ntasks=1
#SBATCH --time=2:00:00
#SBATCH --mem=12G --cpus-per-task=4
#SBATCH --gres=gpu:2


echo hi