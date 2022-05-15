# Shell Script Library solution

Shell script library for abstracting development process on all UNIX like shells.

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

- Happiness steps
    1. Install this library.
    1. Import this library.
    1. Code less by using this library.
    1. Smile!

- Conclusion
    > The commands from this library have not been made to be short. They have been developed to solve these "little" problems and describe their functionalities. Otherwise your source code gets more elegant by removing a lot of commentaries describing what each command does.

<!-- 
## Installation setup

- Requirements
    1. [x] Shell interpreter (such as Sh, Bash or ZSH - you can use it from Git Bash on Windows).
        1. [x] AWK.
        1. [x] Cut.
        1. [x] Echo.
        1. [x] GNU CoreUtils.
        1. [x] Print.
        1. [x] Sed.
        1. [x] Sort.
        1. [ ] 
        1. [ ] 

    1. [ ] Acpi.
    1. [ ] cURL or wGET.
    1. [ ] Docker or Podman.
    1. [ ] OpenRC or SystemD.
    1. [ ] 
    1. [ ] 

- Stable version
    > $ `curl -L -O RELEASE`

    > mv ./FILE_NAME /usr/local/bin/shell-script-library

- Current version
    > $ `curl -sSL https://raw.githubusercontent.com/henrikbeck95/shell_script_library/main/src/compiler.sh`

- Uninstall library
    > $ `rm /usr/local/bin/shell-script-library`
-->

## Usage

```bash
#!/usr/bin/env sh

source /usr/local/bin/shell-script-library
```

## Contribute

If you are a shell script developer consider to contribute by improving the library methods or creating even more solutions.

I know there are a lot of work to be done, but with your help this distance is going to be shorter.