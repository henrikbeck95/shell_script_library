# Task list

## Version 0

### Release 0.0.0 - **Current**

- Focus on implementation of amount solution as functions.
    1. [x] Write a dedicated **Shell Script Library** documentation about the project overview.
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
    1. [x] Create **Shell Script Library** display credits function dynamically into the `header.txt` and `header_.txt` files.
    1. [ ] Create **Shell Script Library** update function from itself.
    1. [ ] Deprecate the `./src/compiler.sh` file.
    1. [ ] Create `read` command structures.
        > $ `read -p "Enter a number: " number`

### Release 0.1.0

- Focus on developing solutions
    1. [ ] Create font download function.
    1. [ ] Create font preview function.
    1. [ ] Create downloading games written using shell script function.
    1. [ ] Create YouTube download function.
    1. [ ] Create YouTube preview function on terminal emulator.
    1. [ ] Create YouTube preview function on external player.
    1. [ ] Create Flatpak management without the full command. For example:
        > No needs to use the full command $ `flatpak run org.mozilla.firefox` if the software is already installed. This would become > $ `flatpak run firefox` or > $ `flatpak stop firefox`. Furthermore this must work without setting individual alias. An auto detect strategy must be created to be dynamically.

### Release 0.2.0

- Focus on editing mode.
    1. [ ] Create some video editing by using FFMpeg commands.
    1. [ ] Create some image editing by using ImageMagick commands.
    1. [ ] Create some document editing by using PanDoc commands.

### Release 0.3.0

- Focus on mount point management.
    1. [ ] Improve chroot management methods.
    1. [ ] Improve containers management methods.
    1. [ ] Creating mounting devices methods.

### Release 0.4.0

- Focus on operating system and desktop environment management.
    1. [ ] Create audio control functions.
    1. [ ] Create brightness control functions.
    1. [ ] Create screenshot control functions.
    1. [ ] Create window manager control functions.

### Release 0.5.0

- Focus on package manager compatibility
    1. [ ] Enable Void Linux package manager commands.
    1. [ ] Enable Chocolatey (Windows) package manager commands.
    1. [ ] Enable Pkg (FreeBSD) package manager commands.
    1. [ ] Enable Homebrew (MacOS) package manager commands.
    1. [ ] Implement the debug parameter on package managers functions.
        > `system_pkg_default_repository_synchronize "false" "<softwares_packages>"`
        > `system_pkg_default_repository_synchronize "true" "<softwares_packages>"`

### Release 0.6.0

- Focus on function returning actions
    1. [ ] Create a dedicated regex expressions module.
        > Based on the colors module example.
    1. [ ] Create exit codes status for each possible failure.
        > Insert 'return 0' into the functions for each successful exit code.

        > Run the some function content into sub-shell to validate operation with code exit status.

        > command && ... || return 127 #Code exit status
    1. [ ] Make sure that in case of dependencies requires it must be installed before procedure.

### Release 0.7.0

- Focus on user experience
    1. [ ] Fix possible bugs inside the functions.
    1. [ ] Write a dedicated **Shell Script Library** documentation for each exit code status.
    1. [ ] Write a dedicated **Shell Script Library** documentation about how each programming language can adopt it (Java, JavaScript and Python).
    1. [ ] Write a dedicated **Shell Script Library** documentation for each command usage.
    1. [ ] Migrate documentation to a dedicated wiki page.

## Version 1

<!--
1. [ ] Implement subfunctions to validate the command status in case of success or some error
    > This procedure is going to help the **Shell Script Library** to reduce the `||` commands requests.
1. [ ] Implement primitive types to improve the Shell Script development experience.
    > Simulate local variables to a function and call them using eval inside alias.
-->

### Release 1.0.0

- Focus on annotation tags
    1. [ ] Implement `@Annotation` tags to override functions content.
        > Maybe the function should be unset but it structure must be preserved.

### Release 1.1.0

- Focus on programming language lexical analyzer.

### Release 1.2.0

- Focus on programming language semantic analyzer.

### Release 1.3.0

- Focus on programming language syntax analyzer.

### Release 1.4.0

- Focus on 
    1. [ ] Create alias extensions packs for Java programming language familiar commands based.
    1. [ ] Create alias extensions packs for NodeJS programming language familiar commands based.
    1. [ ] Create alias extensions packs for Python programming language familiar commands based.

## Version 2

### Release 2.0.0

- Focus on performance improve
    1. [ ] Implement _**Bash** variables expansions_ when available.

### Release 2.1.0

- Focus on shell compatibility
    1. [ ] Refactor the source code to satisfy the **POSIX** compatibility.
        > Probably the strategy is going to be replacing arrays structures to use _IFS_ or using temporarily files.
    1. [ ] Implement alternative commands always when required.
        > Set the following for all available functions to try: Bashism method || POSIX method || Fish

### Release 2.1.0

- Focus on alternative shells compatibility
    1. [ ] Refactor the source code to satisfy the [Fish Shell]() compatibility.

## Release 3

### Release 3.0.0

- Focus on _Cron_ operations.

### Release 3.1.0

- Focus on _C lang_ compiler operations.

### Release 3.2.0

- Focus on _kernel_ operations.

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