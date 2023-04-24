module GraphDS

using DataFrames
using Graphs
using CodecZlib
using Revise

include("GraphDataSet.jl")
include("compression/inclusions.jl")
include("graph_generation/graph_gen.jl")

export GraphDataSet, GraphDSDF

export get_generators, test_graph_generator, generate_graphs

export create_default_names, write_to_file, generate_file_string, graph_to_string, write_own_version_to_file, create_default_string

end # module GraphCompress
