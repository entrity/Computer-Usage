# Pry

**Pry** is a ruby gem and a ruby shell that is much more useful than **irb**.

To run it as a repl, just execute `pry` on the command line.

To use it in Ruby code like a debugging breakpoint, insert the call `binding.pry`.

## `.pryrc`
On startup, pry executes code from `~/.pryrc`.

## `_ex_`
Pry offers a special variable `_ex_`, which is like `$!`, except that it provides the most recent exception value even when the most recent exception was caught.

## `ls`
List methods and variables that can be accessed. Invoke with an argument to see what can be accessed on that object.

## `show-source`
Show the source of a function or class.

When you want the source of a super method add the `-s` param:
```ruby
show-source -s foo.some_func
show-source -ss foo.some_func # Get `super` up two levels
```
