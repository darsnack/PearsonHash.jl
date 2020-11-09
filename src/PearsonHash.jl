module PearsonHash

using Random: shuffle!
export hash8, hashn, hashn!

_table = shuffle!(collect(0:255))

"""
    hash8(data::Vector{UInt8}; seed::UInt8 = zero(UInt8))
    hash8(data::AbstractString; seed::UInt8 = zero(UInt8))

Compute the Pearson 8-bit hash for `data` (optionally specify `seed`).
"""
function hash8(data::Vector{UInt8}; seed::UInt8 = zero(UInt8))
    h = seed
    for byte in data
        h = _table[xor(h, byte) + one(UInt8)]
    end

    return h
end
hash8(data::AbstractString; seed::UInt8 = zero(UInt8)) = hash8(Vector{UInt8}(data); seed = seed)

"""
    hashn!([T = UInt128], data::Vector{UInt8}; seed::UInt8 = 0)::T where T

Compute a (`8*n`)-bit hash for data where `n == sizeof(T)` (optionally specify `seed`).
*Note:* `data` will be mutated in-place. See `hashn` for version without mutation.
"""
function hashn!(::Type{T}, data::Vector{UInt8}; seed::UInt8 = zero(UInt8))::T where T
    h = zero(T)
    n = sizeof(T)
    firstbyte = data[1]
    for i in 0:(n - 1)
        data[1] = UInt8((firstbyte + i) % 256)
        h |= T(hash8(data; seed = seed)) << (i * 8)
    end

    return h
end
hashn!(data::Vector{UInt8}; seed::UInt8 = zero(UInt8)) = hashn!(UInt128, data; seed = seed)
"""
    hashn([T = UInt128], data; seed::UInt8 = zero(UInt8))::T where T

Compute a (`8*n`)-bit hash for `Vector{UInt8}(data)` where `n == sizeof(T)` (optionally specify `seed`).
*Note:* `data` is copied to prevent mutation (resulting in extra allocations).
"""
hashn(::Type{T}, data; seed::UInt8 = zero(UInt8)) where T = hashn!(T, Vector{UInt8}(data); seed = seed)
hashn(data; seed::UInt8 = zero(UInt8)) = hashn(UInt128, data; seed = seed)

end # module
