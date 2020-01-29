using Random
Random.seed!(1234)

using PearsonHash
using Test

@testset "PearsonHash.jl" begin
    @test hash8("Test") == hash8("Test")
    @test hash8("Test") == hashn("Test", 1)
    @test_logs (:warn, "hashn does not support n > 16 (results may be wrong)") (hashn("Test", 17); true)
end
