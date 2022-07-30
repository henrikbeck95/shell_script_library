# Boson Treinamentos

## Bash script algorithms

### Shift command

- Using `Shift` command inside while loop
    ```bash
    #!/usr/bin/env sh

    declare -i i

    while [ -n "$1" ]; do
        echo "O parâmetro $i tem o valor: $1"
        i=$[ $i + 1 ]
        shift
    done
    ```

### Math operations

- Using glob shell
    ```bash
    #!/usr/bin/env sh

    var1=$[2 + 6]
    echo $var1

    var$[$var1 * 2]
    echo $var2
    ```

- Using glob shell
    ```bash
    #!/usr/bin/env sh

    var1=10
    var2=5
    var3=2
    var4=$[$var1 * ($var2 - $var3)]

    echo "Resultado: $var4"
    ```

- Using `Bc` single line
    ```bash
    #!/usr/bin/env sh

    var1=100
    var2=30
    resultado=$(echo "scale=4; $var1 / $var2" | bc)

    echo "Resultado: $resultado"
    ```

- Using `Bc` multiple lines
    ```bash
    #!/usr/bin/env sh

    var1=6
    var2=5
    var3=4
    var4=`bc <<EOF

    scale=4
    a1=($var1 * $var2)
    b1=($var3 * $var1)

    a1+b1

    EOF
    `

    echo "Resultado: $var4"
    ```

- Using `Python3`
    ```bash
    #!/bin/bash

    var1=90
    result=`python3 << EOF
    import math
    print(math.sin(math.radians($var1)))
    EOF
    `
    echo "Seno de $var1 é $result"
    ```