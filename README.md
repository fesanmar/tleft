# tleft

Super naive CLI aplication that subtracts timestamps with the format `hh:mm`.

## Usage

Compile it with `stack build` and run `tleft time1 time2...`. A message with the format `Time left -> <hh>:<mm> hours` will be displayed on the screen.

## Example

```CMD
$ tleft 20:12 17:15
Time left: 02:57 hours
```
