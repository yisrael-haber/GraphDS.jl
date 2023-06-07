struct AnomalyGraph 
    graph::SimpleGraph 
    index::Int64 
    graph_prefix::String 
    
    function AnomalyGraph(graph, index, graph_prefix)
        new(graph, index, graph_prefix)
    end
end

struct AnomalyGraphs 
    DataSet::Vector{AnomalyGraph}
    indexing::Dict{Int64, SimpleGraph}
    graph_prefixes::Dict{Int64, String}
    flunksity

    function AnomalyGraphs(Dataset::Vector{AnomalyGraphs})
        indexing = Dict{Int64, String}()
        graph_prefixes = Dict{Int64, SimpleGraph}

        for anomGraph in Dataset 
            indexing[anomGraph.index] = anomGraph
            graph_prefixes[anomGraph.index] = prefix
        end
        new(DataSet, indexing, graph_prefixes)
    end
end

create_default_indices(g_db::Vector{SimpleGraph{Int64}}) = Dict( i => g_db[i] for i in eachindex(g_db))

default_graph_prefix(graph::SimpleGraph, index::Int64) = "PURE-$(index)-$(nv(graph))-$(ne(graph))"

struct AnomalyGraphsDF
    DF::DataFrame

    function AnomalyGraphsDSDF(g_ds::AnomalyGraphs)
        rows = [[index, g_ds.graph_prefix[index], g_ds.DB[index]] for index in keys(g_ds.index)]
        columns = [[rows[i][col] for i in eachindex(rows)] for col in eachindex(rows[1])]
        new(DataFrame(columns, [:index, :graph_prefix, :graph]))
    end
end 