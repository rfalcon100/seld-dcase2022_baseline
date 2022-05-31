#!/usr/bin/env bash
#SBATCH --cpus-per-task=8
#SBATCH --mem 50G
#SBATCH --time 0-0:50:00
#SBATCH -o "slurm/feature_extraction_%j.out"

# example
# >> sbatch ./scripts/run_feature_extraction.sh

# Read the cuda devices
cuda_device=0

echo 'Setting CUDA_VISIBLE_DEVICES to = '
echo $cuda_device

module purge
module load anaconda
source activate audio2022

pwd
echo Start job

# You can compute the default parameters for the FOA version of the dataset with Multi-ACCDOA labels using the command below. Check the code to see how it is implemented.
srun python batch_feature_extraction.py 3


# Similarly to compute the default parameters for the MIC version of the dataset with SALSA-lite features and Multi-ACCDOA labels use the command below.
# python batch_feature_extraction.py 7

echo End of job
conda deactivate

seff %j
