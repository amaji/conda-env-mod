% CONDA-ENV-MOD(1) Version 1.0 | Custom Anaconda environment management

NAME
====

**conda-env-mod** -- Create and configure a custom Anaconda environment
for installing Python packages.

SYNOPSIS
========

| **conda-env-mod** **subcommand** \[**argument(s)**\]
| **conda-env-mod** \[**-h**|**\--help**\]

DESCRIPTION
===========

This script makes very minimal Anaconda environments and generates Lmod
module files for using them. Users can later install and use Python
packages in the environment after loading the modules.

Key points:
-----------

   * no need to *'source\ activate'* or *'conda\ activate'* (csh/tcsh users,
     rejoice!)

   * all users do is a familiar *'module\ use'* and *'module\ load/unload'*

   * generated environments have access to all packages of base Anaconda
     (but users can also install their extras into environment)

   * no more permission errors when Google tells user to do a *'pip\ install'*

   * sane Jupyter kernels


USAGE
=====

| **conda-env-mod** *subcommand* *\[...arguments\...\]*
| **conda-env-mod** **create** \[**-n** *env_name*|**-p** *env_path*\] \[**-m** *module_dir*\]
| **conda-env-mod** **delete** \[**-n** *env_name*|**-p** *env_path*\] \[**-m** *module_dir*\]
| **conda-env-mod** **module** \[**-n** *env_name*|**-p** *env_path*\] \[**-m** *module_dir*\]
| **conda-env-mod** **kernel** \[**-n** *env_name*|**-p** *env_path*\]
| **conda-env-mod** **help**


EXAMPLES
========

| *conda-env-mod create -n my_test*
| *conda-env-mod create -p /my/project/dir/my_test*
| *.....*
| *module use $HOME/privatemodules*
| *module load conda-env/my_test-py3.6.4*
| *conda install ....*
| *pip install ....*


SUBCOMMANDS
===========

**create**
   Create an environment. Must specify *env_name* or *env_path*.

**delete**
   Delete an existing environment.
   Must specify *env_name* or *env_path*.

**module**
   Create a module file for an existing environment.
   Must specify *env_name* or *env_path*.

**kernel**
   Create a Jupyter kernel for an existing environment.
   Must specify *env_name* or *env_path*.

**help**
   Display brief usage information.


ARGUMENTS
=========

Required (pick one):
--------------------

**-n**, **\--name** *env_name*
   Name of the environment.

**-p**, **\--prefix** *env_path*
   Location of the environment.

Optional:
---------

**-a**, **\--appname** *app_name*
   Name of the module corresponding to the environment. Default value
   is *'conda-env'*.

**-m**, **\--moduledir** *module_dir*
   Location of the module file. Default value is *$HOME/privatemodules*.

**-y**, **\--yes**
   Assume *\"yes\"* to all internal questions. Default is to ask
   confirmations interactively.

**-j**, **\--jupyter**
   When performing **"create"** or **"module"**, also generate a
   Jupyter kernel for this environment. This option will also imply
   *'\--local-python'*. Default is to skip Jupyter kernel creation.

**\--local-py**, **\--local-python**, **\--add-path**, **\--add-to-path**
   By default, generated modulefiles rely on Python interpreter from
   the base Anaconda (new environment's "bin" directory is *not*
   added to $PATH). While this is intentional and often desired, for some
   occasions you might need to do the opposite and use Python (and other
   commands) from the new environment instead. One notable use case is
   when creating a Jupyter kernel for new environment, or occasionally
   when some of your desired packages conflict with their counterparts in
   the base Anaconda. Another use case may be when your packages generate
   additional executables that you want to call from the command line.
   This switch will tweak the generated modulefile to prepend environment's
   "bin" directory to the $PATH. 

   > Note that if you go this route, base Anaconda packages become
   >  unavailable, so you would have to install *all* of your necessary
   > packages into the environment.

To summarize:
-------------

  * In default mode, resulting environment uses *base* Python and all of
    the base's existing packages, while *'pip\ install'* and *'conda\ install'*
    conveniently install new packages into the environment.

  * In the **'\--local-python'** mode, your resulting environment uses the
    *environment's* Python, and does *not* see any of the base Anaconda
    packages. So you would have to *'pip\ install'* and *'conda\ install'*
    everything you need.

  * No matter what mode, **do not use** *'pip\ install\ \--user'* (you want
    your packages to go into the environment, not into
    *$HOME/.local/lib/pythonX.Y/site-packages*).

When generating Jupyter kernels (**"kernel"** mode or **'\--jupyter'**),
everything about **'\--local-python'** above applies. Additionally, we
highly recommend installing your packages from the command line.
**DO NOT USE** plain *'!pip\ install'* or *'!conda\ install'* from inside
the Jupyter notebook! See excellent explanation why here:

http://jakevdp.github.io/blog/2017/12/05/installing-python-packages-from-jupyter/

If you do need to install packages from inside a notebook, use either of
these calls in a cell:

```
!{sys.executable} -m pip install .....
!conda install --yes --prefix {sys.prefix} .....
```

The *'{sys.executable}'* and *'{sys.prefix}'* tokens make sure that
the kernel's own tools are used (and not ones from the separate
JupyterHub installation itself), so packages get installed in the right
location and remain visible for the kernel.


OPTIONS
=======

**-h, \--help**
   Prints brief usage information.


BUGS
====

No known bugs.

Please report issues on Github:
https://github.com/amaji/conda-env-mod/issues


AUTHOR
======

Amiya K Maji and Lev Gorenstein, Purdue University


SEE ALSO
========

**conda-env-mod(1)**, **conda-env**

A few sample use cases:
https://www.rcac.purdue.edu/knowledge/brown/run/examples/apps/python/packages
