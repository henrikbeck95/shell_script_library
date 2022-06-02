# About **Shell Script Library** project

## The history of this project

I was developing a project to my Science Computing graduation called [Voice Assistant for Linux](https://github.com/henrikbeck95/voice_assistant_linux) and a personal project called [SilverArch](https://github.com/henrikbeck95/silverarch). Both of them require shell script programming language to be executed.

After a while I have noticed the following stuffs:
    1. The Shell Script programming language is very powerful but it is not so human readable such as others programming languages (Java, JavaScript or Python).
    1. Once Shell Script programming language can integrate any other installed software on your operating system to be used, their command flags can be extremely hard to be understood if you are not familiar with that specific tool.
    1. If you need a shell script algorithm there are a lot of solutions available but if you are not familiar with Unix like operating system, these commands can become a nightmare. Even their source code have been written without any malicious intention, a single command not properly filtered might accidentally override the files on your operating system.
    1. When developing projects using Shell Script programming language I do not want to spend time filtering their data or searching on web about an algorithm, debugging the available source code into an isolated environment to test it and also to be sure this is trusted. All I really want is to focus on the developing workflow and solve the problem.
    1. The source code from both of the projects should be so much shorter and easy to manage if I could skip the filtering commands functions needs.
    1. I used to have the same redundances into every source code written using Shell Script programming language. There used to be a lot of methods whose were dedicated to filter the possibles errors from the functions inside my projects. Furthermore when I had to update a single method from one project I had to redo the same work into the another project source code.
    1. The Shell Script programming language is not a good idea to separate the source code from your project into dedicated files. Each import of a file reduces the performance. It must be done wisely.
    1. I used to write a lot individual scripts to help me doing my personal tasks. The majority of them could be merged into one single file.

I have searched for many of libraries from third developers but there was any project which could solve the basic solutions. So, I have been starting developing my own source code, my own library totally written using Shell Script programming language. And that's all about how **Shell Script Library** has started.

## The others projects success cases

- SilverArch
    > In my personal [SilverArch](https://github.com/henrikbeck95/silverarch) project, I was developing my own operating system based on ArchLinux. I had more than 4000 lines inside one single file. It was very helpful to be this way because I could download, install and run all source code with a single command on terminal. Then the script was set to transform the ArchLinux black screen into an final user operating with graphical interface and all the essentials applications installed and configured.

    > After **Shell Script Library** has been implemented to this script, I could reduce to about 1200 number of lines to do all the same work it should be done.

<!--
- Voice Assistant for Linux
    > ???
-->