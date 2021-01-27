# tleft
Super naive program written in Haskell to subtract two timestamps with the format `hh: mm`. 

## Usage
Compile it with `ghc tleft.hs` and run `tleft <timestamp1> <timestamp2>`. If it's executed with a different timestamp format than allowed or with 
fewer arguments than two, it will print a non-customized error message. Otherwise, a message with the format `Time left: <hh>:<mm> hours` will be displayed on the screen.

## Example
```
$ tleft 20:12 17:15
Time left: 2:57 hours
```
