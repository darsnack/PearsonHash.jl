using Random
Random.seed!(1234)

using PearsonHash
using Test

@testset "PearsonHash.jl" begin
    @test hash8("Test") == 77
    @test hashn("Test", 2) == 0x0000000000000000000000000000424d
    @test hashn("Test", 4) == 0x0000000000000000000000001f6a424d
    @test_logs (:warn, "hashn does not support n > 16 (results may be wrong)") (hashn("Test", 17); true)
end
