function create_default_names(g_db::Vector{Graphs.SimpleGraphs.SimpleGraph{Int64}})
    Dict( "PURE $i" => g_db[i] for i in eachindex(g_db))
end

function graph_to_string(graph::SimpleGraph, name::String)
    graph_string = "$(name)-$(nv(graph))-$(ne(graph))"
    edges_string = map(x->",$(src(x)),$(dst(x))", edges(graph)) |> join
    graph_string * edges_string * "\n"
end

function generate_file_string(g_db::GraphDB)
    reverse_dict_mapping = reverse_names_dict(g_db)
    map(x->graph_to_string(x, reverse_dict_mapping[x]), g_db.DB) |> join
end

function write_own_version_to_file(g_db::GraphDB, file_name)
    text = g_db |> generate_file_string 
    compressed = transcode(GzipCompressor, Vector{UInt8}(text))
    open(file_name, "w") do io
        write(io, compressed)
    end;
end

function write_to_file(gdb::GraphDB, file_name::String)
    open(file_name, "w") do io
        Graphs.savelg_mult(io, gdb.names)
    end;
end