#!/usr/bin/env bash

# set -x #DEBUG - Display commands and their arguments as they are executed.
# set -v #VERBOSE - Display shell input lines as they are read.
# set -n #EVALUATE - Check syntax of the script but don't execute.


# -------------------------------------------------
# Description:  commandine tool for iMessage APIs
# Create by:    Kamontat Chantrachirathumrong
# Since:        28/10/2560 - DD/MM/YYYY
# -------------------------------------------------
# Error code    1      -- error
# -------------------------------------------------


cd "$(dirname "$(realpath "$0")")"

osascript ./main.scpt $@
