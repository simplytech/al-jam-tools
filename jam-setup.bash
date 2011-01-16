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

# To rename Boost Jam from bjam to jam, however, jam already exists, so I renamed it to al-jam.
# The name should not contain 'bjam' because they do a wildcard search on argv[0] to determine
# if we want to run jam or bjam

alias j='al-jam' 
alias js='. ~/code/al-jam-tools/jam-setup.bash'

# Execute a step at Page <n>
# Example:
#   p 4
# will execute:
#  rails new chapter-1

p()
{
  al-jam -o .my-cmd.tmp "$@" && \
  tail -n +2 .my-cmd.tmp > .my-cmd && \
  chmod +x .my-cmd && \
  .my-cmd
}

# Submit or check-in
s()
{
  git add .
  git commit -m "Page $@"
  git tag -f "$@"
  git push origin master
}

