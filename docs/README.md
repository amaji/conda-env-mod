This repository contains Sphinx configuration and documentation files for conda-env-mod.

**Sources:** Source files are currently in `source`.

**Output:** Html docs can be found in `build/html/`. Load `build/html/index.html` in your browser.

**Building:** We assume that you have installed anaconda and have the `sphinx-build` command in your `$PATH`. This can be easily done by loading the `anaconda` module and then running `make html` at the top-level directory. You need to install the following packages in Python to build this documentation:  

    - Sphinx  
    - sphinx-rtd-theme
 

A simple script for building html docs locally on the clusters is provided in `source/build-html.sh`. Run the script from inside `source`.  

  ```
     [source] $ ./build-html.sh
  ```

**Theme:** We are using the [Read the Docs Sphinx Theme](https://sphinx-rtd-theme.readthedocs.io/en/stable/) to generate html files.
