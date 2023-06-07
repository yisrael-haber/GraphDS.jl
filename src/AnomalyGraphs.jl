module AnomalyGraphs

using DataFrames
using Graphs
using CodecZlib
using Revise

include("GraphDataSet.jl")
include("compression/inclusions.jl")
include("graph_generation/graph_gen.jl")

export GraphDataSet, GraphDSDF

export get_generators, test_graph_generator, generate_graphs

export write_to_file, generate_file_string, read_from_file

export default_graph_prefix, create_graph_string, create_default_indices

end 
