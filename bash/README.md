A word on startup files

_.bash\_profile_ is executed for login shells, while _.bashrc_ is executed for
interactive non-login shells (i.e., you've already logged in and just
opened up a new Xterm window or something of that nature).  So, things which
need to be set at the beginning of a particular session should be in
_.bash\_profile_ and items that need to be defined at the next level of shell
level need to be defined in _.bashrc_.

