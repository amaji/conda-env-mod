#!/bin/bash
# This script prints an Lmod module file for a Python environment.
# All the variables and conditional statements are evaluated inside "conda-env-mod"
# using the "source" function in bash.
# -----------------------------------------------------------------------------------------
# Useful varibales defined by "conda-env-mod"
# ENV_DIR := path to environment
# $PY := full pyhton version, e.g., 3.10.11
# $PY_S := short python version, e.g., 3.10
# Opt_LOCAL_PY := 0|1, 
#						1 means use python from the environment
#						0 means use python from base anaconda
#------------------------------------------------------------------------------------------

cat <<-EOF
	-- created on $(date) by $USER

EOF

if [ "${CONDA_MODULE}" != "" ]; then
	cat <<-EOF
		depends_on("${CONDA_MODULE}")
	EOF
elif [ -f "${CONDA_PREFIX}/bin/conda" ]; then
	cat <<-EOF
		-- Use the base conda that created this environment.
		prepend_path("PATH","${CONDA_PREFIX}/bin")
	EOF
else
	echo -e "WARNING: Couldn't find an anaconda module.\nPlease make sure you initialize conda separately." >&2
fi

cat <<-EOF
	local modroot = "${ENV_DIR}"
	local pyver   = "${PY}"

	pushenv("CONDA_PREFIX",modroot)
	pushenv("CONDA_DEFAULT_ENV",modroot)
	prepend_path("LD_LIBRARY_PATH",modroot.."/lib")
	prepend_path("PYTHONPATH",modroot.."/lib/python${PY_S}/site-packages")
	pushenv("PYTHONNOUSERSITE","1")

EOF

if [[ $Opt_LOCAL_PY -eq 0 ]]; then
	# if user put down base-python, then use Python from base Anaconda
	cat <<-EOF
		-- This line is deliberately commented out.
		-- We want to use Python from base Anaconda.
		-- prepend_path("PATH",modroot.."/bin")

		local bashStr = 'eval '..modroot..'/bin/pip "\$@"'
		local cshStr  = "eval "..modroot.."/bin/pip \$*"
		set_shell_function("pip",bashStr,cshStr)
		-- If this is Python3 environment, brace against 'pip3', too
		if (string.match(pyver,"^3%.")) then
		    set_shell_function("pip3",bashStr,cshStr)
		end

	EOF
else
	# python from the environment (python -V) is added to PYTHONPATH by default
	cat <<-EOF
		-- Using Python and tools from the environment
		prepend_path("PATH",modroot.."/bin")

	EOF
fi
