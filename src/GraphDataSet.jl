struct GraphDataSet
    DB::Vector{SimpleGraph{Int64}}
    index::Dict{Int64, SimpleGraph{Int64}}
    purity::Dict{Int64, Bool}
    graph_string::Dict{Int64, String}

    function GraphDataSet(DB::Vector{SimpleGraph{Int64}})
        index = create_default_indices(DB)
        purity = Dict( i => true for i in eachindex(DB))
        graph_to_index = Dict( y=>x for (x, y) in index)
        graph_string = Dict( x=>create_default_string(x, graph_to_index[x]) for x in DB)
        new(DB, index, purity, graph_string)
    end
end

reverse_index_dict(g_db::GraphDataSet) = Dict( y=>x for (x, y) in g_db.index)

struct GraphDSDF 
    DF::DataFrame

    function GraphDSDF(g_ds::GraphDataSet)
        new(DataFrame(names=g_ds.names, DB=g_ds.DB, purity=g_ds.purity, graph_string=g_ds.graph_string))
    end
end 