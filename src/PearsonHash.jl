module PearsonHash

using Random: shuffle!
export hash8, hashn

_table = shuffle!(collect(0:255))

function hash8(data::Array{UInt8}, seed::UInt8 = zero(UInt8))
    h = seed
    for byte in data
        h = _table[xor(h, byte) + 1]
    end

    return h
end
hash8(data::AbstractString, seed::UInt8 = zero(UInt8)) = hash8(Vector{UInt8}(data), seed)

"""
    hashn(data, n, seed::UInt8 = 0)::UInt128

Compute a (`8*n`)-bit hash for data (optionally specify `seed`).
"""
function hashn(data::Array{UInt8}, n::Integer, seed::UInt8 = zero(UInt8))
    (n > 16) && @warn "hashn does not support n > 16 (results may be wrong)"

    h = UInt128(0)
    for i in 0:(n - 1)
        firstbyte = UInt8((data[1] + i) % 256)
        h |= hash8([firstbyte; data[2:end]], seed) << (i * 8)
    end

    return h
end
hashn(data::AbstractString, n::Integer, seed::UInt8 = zero(UInt8)) = hashn(Vector{UInt8}(data), n, seed)

end # module
