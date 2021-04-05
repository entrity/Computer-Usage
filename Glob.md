```bash
shopt -s extglob
cp !(*Music*) /target_directory
```

The full available extended globbing operators are (excerpt from man bash):

> If the extglob shell option is enabled using the shopt builtin, several extended pattern matching operators are recognized.A pattern-list is a list of one or more patterns separated by a |. Composite patterns may be formed using one or more of the following sub-patterns:

> `?(pattern-list)`
> Matches zero or one occurrence of the given patterns
> `*(pattern-list)`
> Matches zero or more occurrences of the given patterns
> `+(pattern-list)`
> Matches one or more occurrences of the given patterns
> `@(pattern-list)`
> Matches one of the given patterns
> `!(pattern-list)`
> Matches anything except one of the given patterns
