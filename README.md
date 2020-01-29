# PearsonHash

[![Build Status](https://travis-ci.com/darsnack/PearsonHash.jl.svg?branch=master)](https://travis-ci.com/darsnack/PearsonHash.jl)

This package provides utility functions for [Pearson hashing](https://en.wikipedia.org/wiki/Pearson_hashing). You can use the standard 8-bit hash function:
```julia
julia> hash8("Test")
77
```
Or use `hashn` to get multiple of 8 bits (i.e. (`8*n`)-bit hash):
```julia
julia> hashn("Test", 2)
0x0000000000000000000000000000424d
```

Note that `hashn` always returns a `UInt128` integer, so you will need to convert this to a smaller data type if necessary.