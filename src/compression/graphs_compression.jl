function create_default_indices(g_db::Vector{SimpleGraph{Int64}})
    Dict( i => g_db[i] for i in eachindex(g_db))
end

function create_default_string(graph::SimpleGraph, index::Int64)
    graph_string = "PURE-$(index)-$(nv(graph))-$(ne(graph)) "
    edges_string = map(x->",$(src(x)),$(dst(x))", edges(graph)) |> join
    graph_string * edges_string * "\n"
end

#=
function graph_to_string(graph::SimpleGraph, index::Int64, purity::Bool)
    graph_string = "$(index)-$(purity)-$(nv(graph))-$(ne(graph)) "
    edges_string = map(x->",$(src(x)),$(dst(x))", edges(graph)) |> join
    graph_string * edges_string * "\n"
end
=#

function generate_file_string(g_ds::GraphDataSet)
    graph_to_index = reverse_index_dict(g_ds)
    map(x->graph_to_string(x, graph_to_index[x], g_ds.purity[graph_to_index[x]]), g_ds.DB) |> join
end

function write_own_version_to_file(g_db::GraphDataSet, file_name)
    text = g_db |> generate_file_string 
    compressed = transcode(GzipCompressor, Vector{UInt8}(text))
    open(file_name, "w") do io
        write(io, compressed)
    end;
end

function write_to_file(gdb::GraphDataSet, file_name::String)
    open(file_name, "w") do io
        Graphs.savelg_mult(io, gdb.names)
    end;
end