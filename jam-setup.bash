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

if [ "$1" == "" ] ; then
  echo Must specify PROJECT_ROOT as arg1
  return
fi

if [ "$2" == "" ] ; then
  echo Must specify RAILS_APP as arg2
  return
fi

#Example:
alias js="source ~/code/al-jam-tools/jam-setup.bash ~/rails_projects/rails3-unr photos"

unset TOP
unset JAMRULES
unset JAMFILE
unset JAM_DEBUG
unset JAM_DEBUG_INCLUDED_FILES

export TOP=~/code/al-jam-tools
export JAMRULES=$TOP/rules.jam
export JAMFILE=$TOP/makefile.jam
export PROJECT_ROOT=$1
export RAILS_APP=$2

#export JAM_DEBUG=1
#export JAM_DEBUG_INCLUDED_FILES=1
   
echo TOP=$TOP
echo JAMRULES=$JAMRULES
echo JAMFILE=$JAMFILE
echo PROJECT_ROOT=$PROJECT_ROOT
echo RAILS_APP=$RAILS_APP

# To rename Boost Jam from bjam to jam, however, jam already exists, so I renamed it to al-jam.
# The name should not contain 'bjam' because they do a wildcard search on argv[0] to determine
# if we want to run jam or bjam

alias j='al-jam' 

# Execute a step at Page <n>
# Example:
#   cd ~/rails_projects/rails3-unr
#   p 4
# will execute:
#  rails new chapter-1

# Execute commands on Page <n>
p()
{
  # The 'tail' is needed because jam seems to generate an empty line at the beginning of the output file, which messes up the shebang processing, since shebang should be on the first line.  What this means is that we cannot use jam directly to execute stuff using JAMSHELL, instead we have to use this function.

  # I would love to use -d0, but not only does it suppress debugging messages, it also does not generate any output using the -o to the output file!

  #al-jam -d0 -o .my-cmd.tmp "$@"
  al-jam -o .my-cmd.tmp "$@" && \
  tail -n +2 .my-cmd.tmp > .my-cmd && \
  chmod +x .my-cmd && \
  ./.my-cmd
}

# Execute commands on Page <n>, and submit (i.e. commit)
pp()
{
  p "$@"
  s "$@"
}

# Execute commands on Page <n> intercatively
i()
{
  p "$@"
  echo 'Press <ENTER> to continue to next command or <Ctrl-C> to abort.'
  read x
}

# Submit or check-in
s()
{
  export CUR_DIR=`pwd`
  cd $PROJECT_ROOT

    git add .
    git commit -m "Page $@"
    git tag -f "$@"
#    git push origin master

  cd $CUR_DIR
}

