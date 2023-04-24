using Test
using Graphs
using rgdbg
using DataFrames
using Tables
using Parquet2

@testset "Single graph to Parquet2 Chars" begin
    g = random_regular_graph(200, 4)
    chars = Parquet2.writefile(Vector{UInt8}, graph_cols_to_df(g))
    println("Graph generator is random_regular_graph(200, 4). Number of generated Parquet charcters is:")
    @test begin println(chars |> length); 
        return true
    end
end

@testset "Checking Parquet is an invertible process" begin
    g = random_regular_graph(200, 4)
    g_df = graph_cols_to_df(g)
    chars = Parquet2.writefile(Vector{UInt8}, g_df)

    println("The original size of graph g takes $(Base.summarysize(g)) bytes in memory")
    println("The compression ratio of the graph DataFrame is $(Base.summarysize(g_df) / length(chars))")
    
    @test (g_df == chars_to_df(chars))
end