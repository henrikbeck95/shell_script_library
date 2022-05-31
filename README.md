# Shell Script Library

Shell script functions collection for abstracting development process, and speed up the productivity and clear the source code.

## Description

Do you have any idea how much time have you ever been wasting trying to solve problems such as replacing text from a specific file?

Do not waste your time coding that same function to every single script file. Focus your time developing what needs to be done by using the abstractions from this library. Because the source code workflow is more important than solving a lot of "little" problems whose are already solved by us.

- Advantages
    1. Easy installation setup.
    <!--1. All functions in one single file.-->
    1. Described functions names (you can reduce lines by removing the unneeded commentaries).
    1. The function return only what it is expected (nothing more, nothing less).
    1. If you have developed your source code using this library and by some reason you are not satisfied by the result from our functions, just edit the function you need from the `/usr/local/bin/shell-script-library` file and all your function calls will be changed without replacing one single line on your source code. It sounds like magic, doesn't it!?
    1. If have developed your source code using this library and for some reason the newest update breaks your code, you can specify what library version release is going to be installed.
    1. Compatibility between `BSD`, `Linux`, `MacOS`, `Unix` and `WSL` operating system. Furthermore it is able to be run on Windows by using `Git Bash` prompt.

- Step by step to the happiness
    1. Install this library.
    1. Import this library.
    1. Code less by using this library.
    1. Smile!

- Conclusion
    > The commands from this library have not been made to be short. They have been developed to solve these "amount of little" problems and describe their functionalities. Otherwise your source code gets more elegant by removing a lot of commentaries describing what each command does.

## Installation setup

### Requirements

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
    1. [ ] cURL or wGET.
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

```bash
#!/usr/bin/env sh

source /usr/local/bin/shell-script-library

#Insert your code here...
```

### Development

1. Clone the repository on latest version
    > $ `git clone --branch development https://github.com/henrikbeck95/shell_script_library`

1. Give executable permission to the script
    > $ `chmod +x./shell_script_library/src/compiler.sh -crun`
    
1. Compile the modiles and install it on your system for all users
    > $ `./shell_script_library/src/compiler.sh -crun`

## Contribute

If you are a shell script developer consider to contribute by improving the library methods already set or creating even more solutions.

We have a lot of work to be done. Maybe with your help this distance might be a little shorter.