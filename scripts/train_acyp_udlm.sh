#!/bin/bash
#SBATCH --job-name=train_protein
#SBATCH --output /home/lyz6/Job_Logs/protein_benchmark/UDLM%J.log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=larry.zhao@yale.edu
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=32gb
#SBATCH --gpus=1
#SBATCH --constraint="h100|a100"
#SBATCH --time=6:00:00
date;hostname;pwd

module load miniconda
conda activate discdiff
cd /home/lyz6/scratch/mdlm

python main.py \
  loader.batch_size=128 \
  loader.eval_batch_size=128 \
  model=small \
  data=acyp \
  wandb.name=udlm-acyp \
  parameterization=d3pm \
  backbone=dit \
  model.length=128 \
  zero_recon_loss=True \
  sampling.steps=1000 \
  sampling.use_cache=False \
  training.guidance=null \
  time_conditioning=True \
  T=0 \
  trainer.val_check_interval=1.0

