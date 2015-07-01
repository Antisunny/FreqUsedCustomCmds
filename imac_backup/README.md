#iMac Backup

## Structure
- `bash_profile` is the core file
- `bash_functions`, `bash_variables`, `bash_aliases` are imported into `bash_profile`
    - `bash_functions` contains all the custom functions to be used in CommandLine
    - `bash_variables` contains all the aliases
    - `bash_variables` contains all the variables, including *PATH*, *LC_**
```bash
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
#custom variables
if [ -f ~/.bash_variables ]; then
    . ~/.bash_variables
fi
#custom functions
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi
# in .bash_profile
```

