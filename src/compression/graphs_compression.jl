src_and_dst_string(edge::Edge) = ",$(src(edge)),$(dst(edge))"

function create_graph_string(graph::SimpleGraph, index::Int64, graph_prefix::String)
    graph_prefix * (edges_string = map(x->src_and_dst_string(x), edges(graph)) |> join) * "\n"
end

function generate_file_string(g_ds::AnomalyGraphs)
    [(create_graph_string(g_ds.DB[id], id, g_ds.graph_prefix[id])) for id in keys(g_ds.index)] |> join
end

gzip(str::String) = transcode(GzipCompressor, Vector{UInt8}(str))

function write_own_version_to_file(g_db::AnomalyGraphs, file_name)
    compressed_graph_ds_string = g_db |> generate_file_string |> gzip
    open(file_name, "w") do io
        write(io, compressed_graph_ds_string)
    end;
end