#       .o8
#      "888
#  .oooo888   .ooooo.  oooo    ooo  .ooooo.   .ooooo.  ooo. .oo.  .oo.   oo.ooooo.
# d88' `888  d88' `88b  `88.  .8'  d88' `"Y8 d88' `88b `888P"Y88bP"Y88b   888' `88b
# 888   888  888ooo888   `88..8'   888       888   888  888   888   888   888   888
# 888   888  888    .o    `888'    888   .o8 888   888  888   888   888   888   888
# `Y8bod88P" `Y8bod8P'     `8'     `Y8bod8P' `Y8bod8P' o888o o888o o888o  888bod8P'
#                                                                         888
#                      ~/.bash_aliases                                   o888o


# Remove orphaned packages.
# Needs single quotes, otherwise the newlines that "pacman -Qqdt" outputs
# cause trouble.
# The parentheses create a subshell meaning "set -x" that prints the executed
# Bash commands is unset when the subshell exits at the end of the command.
# Arguments to "pacman -Q":
#    -d restrict output to packages installed as dependencies
#    -t list packages that are no longer required by any installed package
#    -q suppress version numbers of packages (this would confuse pacman -R)

alias cleanup_packages='(set -x; sudo pacman -Rs $(pacman -Qdtq))'
