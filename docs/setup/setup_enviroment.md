# System environment

Set **Shell Script Library** to be loaded on your profile shell to easy access their functionalities when you need this.

## Setup steps

1. Copy and paste the following code on into the bottom of your `$HOME/.bashrc` or `$HOME/.zshrc` file
    ```bash
    shell_script_library(){
        local SHELL_SCRIPT_LIBRARY_GLOBAL="/usr/local/bin/shell-script-library"
        local SHELL_SCRIPT_LIBRARY_LOCAL="$HOME/.local/bin/shell-script-library"

        #Check if Shell Script library is installed to import it
        if [ -f $SHELL_SCRIPT_LIBRARY_GLOBAL ] || [ -f $SHELL_SCRIPT_LIBRARY_LOCAL ]; then
            . "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
                . "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null
        else
            #Downloading Shell Script Library
            curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O ||
                wget github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library

            #Installing Shell Script Library
            mv ./shell-script-library "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
                mv ./shell-script-library "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null

            #Giving executable permission to Shell Script Library
            chmod +x "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
                chmod +x "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null

            . "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
                . "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null
        fi
    }

    shell_script_library
    ```

1. Reload your shell to apply the new settings
    > $ `source $HOME/.bashrc`
	
	Or

	> $ `source $HOME/.zshrc`

1. Enjoy it!

## Testing

Try one of the following commands to test if everything has been setup correctly:

1. Math equations
    - Result must **3.14159265358979323846**
        > $ `math_pi`
    
    - Result must **32**
        > $ `math_pow "2" "5"`
    
    - Result must **3**
        > $ `math_sqrt "27" "3"`

<!--
1. Package manager
    - Update the operating system packages
		> $ `system_pkg_default_repository_syncronize`
    
    - Update the operating system packages
        > $ `sudo system_pkg_default_repository_syncronize`
-->