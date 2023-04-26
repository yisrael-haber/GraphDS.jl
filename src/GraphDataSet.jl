struct GraphDataSet
    DB::Vector{SimpleGraph{Int64}}
    index::Dict{Int64, SimpleGraph}
    graph_prefix::Dict{Int64, String}

    function GraphDataSet(DB::Vector{SimpleGraph{Int64}})
        index = create_default_indices(DB)
        graph_to_index = Dict( y=>x for (x, y) in index)
        graph_prefix = Dict( graph_to_index[x]=>graph_string_prefix(x, graph_to_index[x]) for x in DB)
        new(DB, index, graph_prefix)
    end

    function GraphDataSet(DB::Vector{SimpleGraph{Int64}}, index::Dict{Int64, SimpleGraph{Int64}}, graph_prefix::Dict{Int64, String})
        new(DB, index, graph_prefix)
    end
end

reverse_index_dict(g_db::GraphDataSet) = Dict( y=>x for (x, y) in g_db.index)

create_default_indices(g_db::Vector{SimpleGraph{Int64}}) = Dict( i => g_db[i] for i in eachindex(g_db))

graph_string_prefix(graph::SimpleGraph, index::Int64) = "PURE-$(index)-$(nv(graph))-$(ne(graph))"

struct GraphDSDF 
    DF::DataFrame

    function GraphDSDF(g_ds::GraphDataSet)
        rows = [[index, g_ds.graph_prefix[index], g_ds.DB[index]] for index in keys(g_ds.index)]
        columns = [[rows[i][col] for i in eachindex(rows)] for col in eachindex(rows[1])]
        new(DataFrame(columns, [:index, :graph_prefix, :graph]))
    end
end 