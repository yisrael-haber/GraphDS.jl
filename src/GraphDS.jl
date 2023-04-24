module GraphDS

using DataFrames
using Graphs
using Parquet2
using CodecZlib
using Revise

include("GraphDB.jl")
include("compression/inclusions.jl")
include("graph_generation/graph_gen.jl")


export graph_to_df, graph_cols_to_df, chars_to_df, greet, get_generators, test_graph_generator, generate_graphs, graph_db_to_df, df_to_chars, parquet_size, parquet_ratio

export create_default_names, GraphDB, write_to_file, generate_file_string, graph_to_string, reverse_names_dict, write_own_version_to_file

end # module GraphCompress
