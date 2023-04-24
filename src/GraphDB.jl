struct GraphDB
    DB::Vector{SimpleGraph{Int64}}
    names::Dict{String, SimpleGraph{Int64}}
    
    function GraphDB(DB::Vector{SimpleGraph{Int64}})
        names = create_default_names(DB)
        new(DB, names)
    end
end

reverse_names_dict(g_db::GraphDB) = Dict( y=>x for (x, y) in g_db.names)