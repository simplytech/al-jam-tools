#*****************************************************************************#
# File   : jam-setup.bash                                                     #
# Author : Alain Achkar                                                       #
# Summary: Setup env vars for Jam                                             #
#*****************************************************************************#
#                                                                             #
# Usage:                                                                      #
#   (bash) source jam_setup.bash                                              #
#                                                                             #
#*****************************************************************************#

echo 'Setting environment for Jam to use al-jam-tools...'

unset TOP
unset JAMRULES
unset JAMFILE
unset JAM_DEBUG
unset JAM_DEBUG_INCLUDED_FILES

export TOP=~/code/al-jam-tools
export JAMRULES=$TOP/rules.jam
export JAMFILE=$TOP/makefile.jam

#export JAM_DEBUG=1
#export JAM_DEBUG_INCLUDED_FILES=1
   
echo TOP=$TOP
echo JAMRULES=$JAMRULES
echo JAMFILE=$JAMFILE
