# Shell Script Library

Shell script functions collection for abstracting development process, speed up the productivity and clear the source code to be more human.

## Description

Do you have any idea how much time have you ever been wasting trying to solve "little" hard problems such as replacing text from a specific file, calculating math equations, auto unpacking files according their extensions, or even filtering the package manager according to the users operating system to guaranty the dependencies will be installed to run your script properly?

Now how about writing all the same "micro" solutions you have developed in each shell script file you write...!? This sounds like a nightmare, specially in Shell Script whose this programming language can automatize all of your operating system for good or for bad depending on how much your source code filters are robust to avoid problems or redundancies.

Do have have any idea how much commentaries your could remove from your source code because they can be replaced by abstractions with full commands descriptions on their names whose do what they should do!?

Now how about writing your scripts clear than before, specially in long shell script files!?

That's what **Shell Script Library** proposes to be done. One library, a powerful collection of functionalities and a clear source code. All of this by import one single file. **\o/ Wow! \o/**

Now think about when your have to use Shell Script commands inside your favorite programming language such as Java, JavaScript, Python and so on. Sometimes for a specific reason you have to implement a complex functionality to solve your problem. This may sounds another trouble to you because you need to learn Shell Script, isn't it!?

And how about packing the **Shell Script Library** to your project and import it when required without needing to writing shell scripts!? Would it be useful for you or for your project team? You're welcome.

So, focus your time developing what needs to be done by using the abstractions from this library. Because the source code workflow is more important than solving a lot of "little" hard problems whose have already been solved by us. Or in a specific case, you can consult the **Shell Script Library** source code and copy the function you need manually to your project.

- Just one advice:
    > Consider migrating your scripts to use this library.

<!--
### About how this project was created

-->

### Who should migrate to **Shell Script Library** right now

- ArchLinux users is one step ahead to adopt this library in their lives than any other Linux distribution.
    > The reason by this can be related about we have already been developed more functions to PacMan package manager commands so far. In second place is Fedora followed by Ubuntu and Alpine respectively.

### Reasons to use **Shell Script Library**

- Advantages
    1. [x] Easy installation setup.
    
    1. [x] All functions are up be imported from only one single file.
    
    1. [x] Turns your scripts more elegant.
        > Functions names have detailed description (you can reduce the number of lines by removing the unneeded commentaries describing what each command does).
    
    1. [x] The function return only what it is expected (nothing more, nothing less).
    
    1. [x] **Shell Script Library** runs very satisfactory on `Bash` and `ZSH` shells. Furthermore it is able to be run on Windows by using `Git Bash` prompt.

    1. [x] **Shell Script Library** has it owns transpiler.
        1. Easy to developing organizing by modules.
        1. Easy to import the files because there is only one single to be imported.
        1. And this is possible because we merge all the modules files into one single thing automatically.

    1. [x] You can static the **Shell Script Library** version your project should use.
        > In case of deprecated functions on the newest updates, all the older versions are still available to be consulted or downloaded. So, your source code will not breaks up. Unless not by this reason.

    1. [x] Once you have developed your script using **Shell Script Library**, each time this project gets updated your script also becomes more powerful with no need to replace even one single line on your source code. I know it may sound like magic but it is well-designed. Unless that's the idea.

    1. [x] **Shell Script Library** is verified by [Shell Check]().
        > We have been using the `#!/usr/bin/env bash` shebang so far.

### Final words

- Step by step to the happiness
    1. Install the **Shell Script Library**.
    1. Import the **Shell Script Library**.
    1. Code less by using the **Shell Script Library**.
    1. Smile!

## Installation setup

### Requirements

- Essential softwares to work.
    1. [x] Bash/ZSH (you can still running it on any other shell but some bugs may happen).
    1. [x] cURL or wGET.
    1. [x] GNU CoreUtils.

<!--
- Essentials
    1. [x] Shell interpreter (such as Sh, Bash or ZSH - you can use it from Git Bash on Windows).
    1. [x] AWK.
    1. [x] Cd.
    1. [x] Clear.
    
    1. [x] GNU CoreUtils.
        <!--1. [x] Arch-\->
        1. [x] Cat.
        1. [x] Chmod.
        <!--1. [x] ChRoot-\->
        1. [x] Cp.
        1. [x] Cut.
        1. [x] Date.
        1. [x] DD.
        1. [x] Echo.
        1. [x] Head.
        1. [x] ln.
        1. [x] ls.
        1. [x] Mkdir.
        1. [x] Mv.
        1. [x] Printf.
        1. [x] Pwd.
        1. [x] Rm.
        1. [x] Sort.
        1. [x] Tail.
        <!--1. [x] Tr-\->
        <!--1. [x] Wc-\->

    1. [x] Grep.
    1. [x] Lsblk.
    1. [x] Mkfs.
    1. [x] Mkswap.
    1. [x] Mount.
    1. [x] Print.
    1. [x] Sed.
    1. [x] Swap.
-->

<!-- 
- Extra softwares
    1. [ ] Acpi.
    1. [x] CFDisk.
    1. [ ] Docker or Podman.
    1. [ ] OpenRC or SystemD.
    1. [ ] Distrobox.
    1. [ ] //notify-send
    1. [ ] Gnome settings
    1. [ ] //BTRFS-progs.
    1. [ ] //BTRFS-utils.
    
    1. [ ] Fc-cache.
    1. [ ] Git.
    1. [ ] ImageMagick.
    1. [ ] Vim.
    
    1. [ ] APK, APT, DNF, Emerge, Pacman, Paru, SlackPKG, YUM or Zypper.
    
    1. [ ] ASDF.
    1. [ ] Node.
    1. [ ] Python - Anaconda.
    1. [ ] Python - Pip.
    1. [ ] Flatpak.
    1. [ ] Snap.
    1. [ ] Rust.
    
    1. [ ] //XDG.
    1. [ ] //XDG-screensaver.
    1. [ ] //XDG-open.
    1. [ ] //XDG-utils.
    
    1. [ ] i3.
    1. [ ] i3wm.
    
    1. [ ] //Gz.
    1. [ ] Tar.
    1. [ ] Xz.
    1. [ ] Zip.
    
    1. [ ] BTRFK.
    1. [ ] Timeshift.
    1. [ ] Snapper.
-->

### Installing

- Download release latest version
    > $ `curl -fsSL github.com/henrikbeck95/shell_script_library/releases/latest/download/shell-script-library -O`

    > $ `mv ./shell-script-library /usr/local/bin/shell-script-library`

- Uninstall library
    > $ `rm /usr/local/bin/shell-script-library`

### Using

#### Using it on terminal

- Import the Shell Script Library
    > $ `source /usr/local/bin/shell-script-library`

- Run a single command. For example:
    > $ `math_pi`

- Output
    > 3.14159265358979323846

#### Using it inside a shell script

- Copy and paste. Then start developing your script file.
    > This procedure auto installs the Shell Script Library when the user runs it is not already installed.

- Shell Script Library auto installation path
    1. If the user executes the script with root privileges 
        > /usr/local/bin/shell-script-library

    1. If the user executes the script without root privileges 
        > $HOME/.local/bin/shell-script-library

```bash
#!/usr/bin/env bash

##############################
#Load Shell Script Library
##############################
#
#The Shell Script Library on the following path:
#By running this shell script file with root privileges:
#/usr/local/bin/shell-script-library
#
#By running this shell script file without root privileges:
#$HOME/.local/bin/shell-script-library
#
##############################

SHELL_SCRIPT_LIBRARY_GLOBAL="/usr/local/bin/shell-script-library"
SHELL_SCRIPT_LIBRARY_LOCAL="$HOME/.local/bin/shell-script-library"

#Check if Shell Script library is installed to import it
if [ -f $SHELL_SCRIPT_LIBRARY_GLOBAL ] || [ -f $SHELL_SCRIPT_LIBRARY_LOCAL ]; then
    . "$SHELL_SCRIPT_LIBRARY_GLOBAL" 2>/dev/null ||
        . "$SHELL_SCRIPT_LIBRARY_LOCAL" 2>/dev/null
else
    printf "Installing Shell Script Library for you..."

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

    #Clear last 10 displayed output messages
    for i in {1..10}; do printf '\033[1A\033[K'; done

    display_message_value_status_success_complex "Shell Script Library is installed successfully! Like a said, no need to worry about it!"
fi

##############################
#Developing the script itself
##############################

#Your source code starts here...
```

### Development

1. Clone the repository on latest version
    > $ `git clone --branch development https://github.com/henrikbeck95/shell_script_library`

1. Give executable permission to the script
    > $ `chmod +x./shell_script_library/src/compiler.sh -crun`
    
1. Compile the modules and install it on your system for all users
    > $ `./shell_script_library/src/compiler.sh -crun`

## Contribute

If you are a shell script developer consider to contribute by improving the **Shell Script Library** to a higher level.
    1. [ ] Consider creating even more solutions.
    1. [ ] Consider improving methods already set.
    1. [ ] Consider testing methods already set.
    1. [ ] Consider documenting methods already set.
    1. [ ] Consider announcing the **Shell Script Library** project.

We have a lot of work to be done. Maybe with your help this distance might be a little shorter and the project gets faster updates.