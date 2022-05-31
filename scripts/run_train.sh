#!/usr/bin/env bash
#SBATCH --gres=gpu:1
###SBATCH --constraint=volta|pascal|ampere
#SBATCH --cpus-per-task=6
#SBATCH --mem 80G
##SBATCH --time 0-3:50:00
#SBATCH --time 0-00:30:00
#SBATCH -o "slurm/train_%j.out"

module purge
module load anaconda #has cuda 10

source activate audio2022

cd pwd

# Read the task_id
task_id=$1

echo 'Setting task_id to = '
echo $task_id


#Sanity check, is the anaconda environment loaded ?
hostname
python -c 'import librosa'
which python
echo "init done"

echo Running experiments


# Finally, for Ambisonic format baseline results, run the following command
srun python train_seldnet.py 3 $task_id


conda deactivate

seff $SLURM_JOBID

