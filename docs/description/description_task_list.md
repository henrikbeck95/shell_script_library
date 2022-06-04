# Task list

## Version 0

### Release 0.0.0 - **Current**

- Focus on implementation of amount solution as functions.
    1. [x] Create a pack of arrays functions.
    1. [x] Create a pack of colors functions.
    1. [x] Create a pack of commentaries functions.
    1. [x] Create a pack of containers functions.
    1. [x] Create a pack of display functions.
    1. [x] Create a pack of math functions.
    1. [x] Create a pack of string functions.
    1. [x] Create a pack of system functions.
    1. [x] Create a pack of time functions.
    1. [x] Create a pack of try/catch functions.
    1. [x] Create a pack of utils functions.
    1. [x] Create a module merger for managing **Shell Script Library** project easily.
    1. [x] Create an unit tester script generator for **Shell Script Library**.
    1. [x] Create **Shell Script Library** display credits function dynamically into the `header.txt` `header_.txt` files.
    1. [ ] Create **Shell Script Library** an update function from itself.
    1. [ ] Deprecate `./src/compiler.sh` file.
    1. [ ] Fix possible bugs inside the functions.
    1. [ ] Assert that command dependencies are installed.

    <!--
    system_pkg_default_repository_synchronize "false"
    system_pkg_default_repository_synchronize "true"
    -->

    <!--
    #read -p "Enter a number: " number
    -->

### Release 0.1.0

- Focus on function returning actions
    1. [ ] Write a dedicated **Shell Script Library** documentation about how each programming language can adopt it (Java, JavaScript and Python).
    1. [ ] Write a dedicated **Shell Script Library** documentation for each command usage.
    1. [ ] Implement flatpak management without the full command. For example:
        > No needs to use the full command $ `flatpak run org.mozilla.firefox` if the software is already installed. This would become > $ `flatpak run firefox` or > $ `flatpak stop firefox`. Furthermore this must work without setting individual alias. An auto detect strategy must be created to be dynamically.
    1. [ ] Implement YouTube download function.
    1. [ ] Implement YouTube preview function on terminal emulator.
    1. [ ] Implement YouTube preview function on external player.
    1. [ ] Implement downloading games written in shell script function.

### Release 0.2.0

- Focus on function returning actions
    1. [ ] Create exit codes status for each possible failure.
        > Insert 'return 0' into the functions for each successful exit code.

        > Run the some function content into sub-shell to validate operation with code exit status.

        > command && ... || return 127 #Code exit status
    1. [ ] Write a dedicated **Shell Script Library** documentation for each exit code status.
    1. [ ] .

### Release 0.3.0

- Focus on operating system and desktop environment management.
    1. [ ] Implement audio control functions.
    1. [ ] Implement brightness control functions.
    1. [ ] Implement screenshot control functions.
    1. [ ] Implement font download function.
    1. [ ] Implement font preview function.

### Release 0.4.0
    
- Focus on mount point management.
    1. [ ] Improve chroot management methods.
    1. [ ] Improve containers management methods.
    1. [ ] Creating mounting devices methods.
    
### Release 0.5.0

- Focus on editing mode.
    1. [ ] Implement some video editing by using FFMpeg commands.
    1. [ ] Implement some image editing by using ImageMagick commands.
    1. [ ] Implement some document editing by using PanDoc commands.
    1. [ ] Implement window manager control functions.

### Release 0.6.0

- Focus on package manager compatibility
    1. [ ] Enable Void Linux package manager commands.
    1. [ ] Enable Chocolatey (Windows) package manager commands.
    1. [ ] Enable Pkg (FreeBSD) package manager commands.
    1. [ ] Enable Homebrew (MacOS) package manager commands.

<!--
### Release 0.7.0

### Release 0.8.0

### Release 0.9.0
-->

## Version 1

### Release 1.0.0

- Focus on programming language lexical, semantic and syntax analyzer.
    1. [ ] Implement subfunctions to validate the command status in case of success or some error
        > This procedure is going to help the **Shell Script Library** to reduce the `||` commands requests.
    1. [ ] Implement `@Annotation` tags to override functions content.
        <!--
        > Maybe unset the function preserving it structures.
        -->
    1. [ ] Implement primitive types to improve the Shell Script development experience.
        <!--
        > Simulate local variables to a function and call them using eval inside alias.
        -->
    1. [ ] Implement _variable expansions_ and alternative commands always when required.

### Release 1.1.0

- Focus on shell compatibility
    1. [ ] Reach the compatibility between `BSD`, `Linux`, `MacOS`, `Unix` and `WSL` operating system. The `POSIX` dream. For running on `Ash`, `Bash`, `Dash`, `Fish`, `Ksh`, `SH` and `ZSH` shells.
        > Probably the strategy to replace arrays structure might be to write the content into a temporary file than load it back.

### Release 1.2.0

- Focus on 
    1. [ ] Create alias extensions packs for Java programming language familiar commands based.
    1. [ ] Create alias extensions packs for NodeJS programming language familiar commands based.
    1. [ ] Create alias extensions packs for Python programming language familiar commands based.

<!--
## The project dreams

- The possible dreams in a short future
    1. [ ] **Shell Script Library** to be available to be installed on _Alpine_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _ArchLinux/AUR_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _RPM Fusion_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _SlackBuilds_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _Ubuntu_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _Void_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _FreeBSD_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _Homebrew_ repository.
    1. [ ] **Shell Script Library** to be available to be installed on _Chocolatey_ repository.

- The biggest dreams
    1. [ ] **Shell Script Library** to be native included on Linux based distributions.
    1. [ ] **Shell Script Library** to be native included on BSD based distributions.
-->