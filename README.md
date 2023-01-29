# Dot Files
Personal tool configurations for Bash and other common tools

The general strategy here is the following:

*~/.bash_profile* just loads *~/.profile* and *~/.bashrc* in that order

*~/.profile* needs to be compatible with any */bin/sh* like bash, dash, the Korn
shell, and anything else that a particular system might choose to deploy.  This
also needs to properly set environment variables for services like GDM and so
forth that explicitly run */bin/sh*. Also, since bash in 'login' mode doesn't
source *~/.bashrc* so it needs to be done manually.

*~/.bashrc* contains everything that goes in an interactive environment -
prompt, variables, aliases, etc.

*~/.bash_login* this shouldn't be around

A word on startup files

_.bash\_profile_ is executed for login shells, while _.bashrc_ is executed for
interactive non-login shells (i.e., you've already logged in and just
opened up a new Xterm window or something of that nature).  So, things which
need to be set at the beginning of a particular session should be in
_.bash\_profile_ and items that need to be defined at the next level of shell
level need to be defined in _.bashrc_.

