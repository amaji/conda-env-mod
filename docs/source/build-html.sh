#!/bin/bash
source /etc/profile.d/modules.sh
module --force purge
module use ~/privatemodules
module load pandoc
module load conda-env/sphinx-env-py3.8.8
module list

cd ..
make clean && make html
