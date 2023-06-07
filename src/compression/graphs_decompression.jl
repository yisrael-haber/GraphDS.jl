de_gzip(str::Vector{UInt8}) = transcode(GzipDecompressor, str) 

parse_graph_prefix(graph_string::SubString{String}) = split(graph_string, ",") |> first |> String

function parse_index(graph_prefix::String) 
    index_string = split(graph_prefix, "-")[2]
    parse(Int64, index_string)
end

function drop_first(vec_of_strings::Vector{SubString{String}})
    vec_of_strings[2:length(vec_of_strings)]
end

function parse_graph_from_string(full_graph_string::SubString{String})
    to_int(str) = parse(Int64, str)

    v_num = split((full_graph_string |> parse_graph_prefix), "-")[3] |> to_int
    graph = Graph(v_num)
    graph_edge_string = split(full_graph_string, ",") |> drop_first 
    
    for i in 1:2:length(graph_edge_string) add_edge!(graph, to_int(graph_edge_string[i]), to_int(graph_edge_string[i + 1])) end
    
    return graph
end

function read_from_file(file_name::String)
    open(file_name, "r") do io
        text = io |> read |> de_gzip |> String
        
        separated_into_graphs = split(text, "\n")
        _ = pop!(separated_into_graphs)

        prefixes = parse_graph_prefix.(separated_into_graphs)
        indices = parse_index.(prefixes)
        graphs = parse_graph_from_string.(separated_into_graphs)
        
        index_dict = Dict( indices[i]=>graphs[i] for i in eachindex(indices))
        prefix_dict = Dict( indices[i]=>prefixes[i] for i in eachindex(indices))
        
        return AnomalyGraphs(graphs, index_dict, prefix_dict)
    end;
end