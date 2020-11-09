# PearsonHash

![Build Status](https://github.com/darsnack/PearsonHash.jl/workflows/CI/badge.svg)

This package provides utility functions for [Pearson hashing](https://en.wikipedia.org/wiki/Pearson_hashing). You can use the standard 8-bit hash function:
```julia
julia> hash8("Test")
77
```
Or use `hashn` to get multiple of 8 bits (i.e. (`8*n`)-bit hash) where `n` is based on the return type specified):
```julia
julia> hashn(UInt16, "Test")
0x424d
```

Note that `hashn` converts the data passed in using `Vector{UInt8}(data)`. This will result in extra allocations if `data` is mutable.

## Documentation

For this simple package, just use the REPL:
```julia
julia> ?hash8
julia> ?hashn!
julia> ?hashn