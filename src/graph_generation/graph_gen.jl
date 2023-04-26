include("valid_graph_generators.jl")

function test_graph_generator(generator::String, params...)
    if (generator ∉ get_generators()) throw(ErrorException("Generator not in valid list of generators")) end
    gen_func = Symbol(generator)
    try 
        b = @eval $(gen_func)($(params...))
        return isa(b, SimpleGraph)
    catch e
        println("YOU TRIED TO USE GENERATOR $(generator) WITH PARAMETERS $(params). THIS RAISED EXCEPTION \n$e")
        return false
    end
end

function generate_graphs(num_to_gen::Int64, generator::String, params...)
    if !test_graph_generator(generator, params...) throw(error()) end

    gen_func = Symbol(generator)
    
    graph_db = [@eval $(gen_func)($(params...)) for i ∈ 1:num_to_gen]
end