
function _simulated_annealing(features::Array{<:Number,2}, labels::Array{<:Number,1}, 
    L::Function, θ::Array{Float64,1}, α::Float64; maxiter::Int64 = 100, verbose::Bool = false)::Array{Float64,1}

    # initialize -
    T = 1.0; # initial temperature
    is_ok_to_continue = true; # should we continue?
    θ̂ = copy(θ); # copy the coefficients, best solution so far

    # main loop -
    while (is_ok_to_continue == true)
        
        # get the current loss -
        L₀ = L(features, labels, θ̂);
        
        # take maxiter steps at a single temperature -
        for _ ∈ 1:maxiter
            
            # propose a new solution -
            θᵢ = θ̂ .+ 0.05*randn(size(θ));
        
            # get the new loss -
            Lᵢ = L(features, labels, θᵢ);
        
            # should we accept the new solution?
            ΔL = Lᵢ - L₀; # loss difference
            if (ΔL < 0)
                θ̂ = θᵢ; # accept the new solution, we have a new winner!
            else
                p = exp(-ΔL/T);
                if (rand() < p)
                    θ̂ = θᵢ; # accept the new solution
                end
            end
        end

        # update the temperature -
        T = T*α;
        
        # should we stay in the loop? (or should we go ...)
        if (T < 0.001)
            is_ok_to_continue = false; # we are done!
        end
    end

    # return the best parameters we found so far
    return θ̂;
end