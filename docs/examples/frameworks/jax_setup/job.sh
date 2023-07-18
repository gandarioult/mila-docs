#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16G
#SBATCH --time=00:15:00

set -e  # exit on error.
echo "Date:     $(date)"
echo "Hostname: $(hostname)"

# Ensure only anaconda/3 module loaded.
module --quiet purge
# This example uses Conda to manage package dependencies.
# See https://docs.mila.quebec/Userguide.html#conda for more information.
module load anaconda/3

# Creating the environment for the first time:
# conda create -y -n jax -c "nvidia/label/cuda-11.8.0" cuda python=3.9 virtualenv pip
# conda activate jax
# Install Jax using `pip`
# *Please note* that as soon as you install packages from `pip install`, you
# should not install any more packages using `conda install`
# pip install --upgrade "jax[cuda11_pip]" \
#    -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# Activate the environment:
conda activate ~/CODE/mila-docs/.tmp/env/cp39/exjax_/


# Fixes issues with MIG-ed GPUs
unset CUDA_VISIBLE_DEVICES

python main.py
