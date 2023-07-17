#!/bin/bash
index=0
declare -A options
options[0]="n"
options[1]="p"
options[2]="nj"
options[3]="pj"
options[4]="np"
options[5]=""
options[6]="j"

while [ $index -lt ${#options[@]} ]; do
	command_args=""
	delete_args=""
	args="${options[$index]}"
	for((i=0;i<${#args};i++)); do
		opt=${args:i:1}
		case "$opt" in
			n)
				command_args+="-n testmod${index} "
				delete_args+="-n testmod${index} "
				;;
			p)
				command_args+="-p $RCAC_SCRATCH/testmod${index} "
				delete_args+="-p $RCAC_SCRATCH/testmod${index} "
				;;
			j)
				command_args+="-j "
				;;
			*)
				;;
		esac
	done

	command="./conda-env-mod create -y -f environment.yaml ${command_args}"
	echo "$command"
	$command

	echo "./conda-env-mod delete -y $delete_args"
	./conda-env-mod delete -y $delete_args

	index=$(expr $index + 1)
	echo "---------------------------------------------------------------"
done

#conda-env-mod create --file environment.yaml; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create --file environment.yaml -n testmod${index}; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create --file environment.yaml -n testmod${index} -j; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create --file environment.yaml -p ${RCAC_SCRATCH}/testmod${index}; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create -f environment.yaml -p ${RCAC_SCRATCH}/testmod${index} -j; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create -f environment.yaml -n testmod${index} -p ${RCAC_SCRATCH}/testmod${index}; index=$(expr $index + 1);
#conda-env-mod delete -n testmod
#conda-env-mod create --file environment.yml -n testmod${index}; index=$(expr $index + 1);
#conda-env-mod create --file environment.yaml.txt -n testmod${index}; index=$(expr $index + 1);

