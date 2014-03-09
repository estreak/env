# .bashrc

# ignore xoff madness from ctrl-s
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
