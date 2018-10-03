# Pre-requisites

## Setup MIDI output device

See [Setting up MIDI](http://www.euterpea.com/euterpea/setting-up-midi/) for details.
Ensure midi output is functioning properly

```shell
stack ghci
> import Euterpea
> devices
```

This should show a list of midi output devices. `> play` will pick the default
output device, use `> playDev n` to output to a particular device.

# Build source & play examples

Code dependencies are configured for use with `haskell-stack`. After installing
[Haskell Stack](https://docs.haskellstack.org/en/stable/README), run `stack ghci Examples.hs` from the src directory, to install deps and enter the `ghci`
repl, here the examples can be executed with the `play` command.
