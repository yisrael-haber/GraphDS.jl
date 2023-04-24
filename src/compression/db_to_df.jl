function graph_cols_to_df(G::SimpleGraph)
    return graph_db_to_df([G])
end

function graph_db_to_df(g_db::Vector{Graphs.SimpleGraphs.SimpleGraph{Int64}})
    graph_indices = reduce(vcat, [[idx for i ∈ 1:ne(G)] for (idx, G) ∈ enumerate(g_db)])
    graph_edge_srcs = reduce(vcat, [[src(edge) for edge ∈ edges(G)] for G in g_db])
    graph_edge_dests = reduce(vcat, [[dst(edge) for edge ∈ edges(G)] for G in g_db])

    return DataFrame(graph_index=graph_indices, src=graph_edge_srcs, dest=graph_edge_dests)
end