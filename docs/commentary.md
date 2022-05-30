# Commentary

## Commentary for multiple lines

- Original method

```bash
: << 'COMMENT'
echo 'This is a text 01'
echo 'This is a text 02'
COMMENT

echo 'This is a text 03'
```

- Shell Script Library way

```bash
%
echo 'This is a text 01'
echo 'This is a text 02'
%%

echo 'This is a text 03'
```

- Annotation
    > In both case the only result whose is going to be displayed it **This is a text 03**.