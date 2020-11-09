using Random
Random.seed!(1234)

using PearsonHash
using Test

@testset "PearsonHash.jl" begin
    @test hash8("Test") == hash8("Test")
    @test hash8("Test") == hashn(UInt8, "Test")
    @test typeof(hashn(UInt32, "Test")) == UInt32
    @test hashn("Test") != hashn("Test"; seed = 0xFF)
end
