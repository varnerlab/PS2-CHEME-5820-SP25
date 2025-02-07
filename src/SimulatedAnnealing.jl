
function _simulated_annealing(features::Array{<:Number,2}, labels::Array{<:Number,1}, 
    L::Function, θ::Array{Float64,1}, α::Float64; maxiter::Int64 = 100, verbose::Bool = false)::Array{Float64,1}

    # initialize -
    T = 1.0; # initial temperature
    is_ok_to_continue = true; # should we continue?
    θ̂ = copy(θ); # copy the coefficients, best solution so far
    number_of_instances = size(features, 1); # how many instances do we have?
    best_loss = Inf; # best loss so far

    # main loop -
    while (is_ok_to_continue == true)
        
        # get the current loss -
        L₀ = 0.0; # initialize the loss
        for i ∈ 1:number_of_instances
            L₀ += L(features[i,:], labels[i], θ̂);
        end
        
        # take maxiter steps at a single temperature -
        for _ ∈ 1:maxiter
            
            # propose a new solution -
            θᵢ = θ̂ .+ 0.01*randn(size(θ));
        
            # get the new loss -
            Lᵢ = 0.0; # initialize the loss
            for i ∈ 1:number_of_instances
                Lᵢ += L(features[i,:], labels[i], θᵢ);
            end
        
            # should we accept the new solution?
            ΔL = Lᵢ - L₀; # loss difference
            if (ΔL < 0)
                θ̂ = θᵢ; # accept the new solution, we have a new winner!
                best_loss = Lᵢ;
                # if (verbose == true)
                #     println("SA routine: Found a better solution at T = $(T) with loss: ", best_loss);
                # end
            else
                p = exp(-ΔL/T);
                if (rand() < p)
                    θ̂ = θᵢ; # accept the new solution
                    best_loss = Lᵢ;

                    # if (verbose == true)
                    #     println("SA routine: Took an uphill at T = $(T) with loss ", best_loss);
                    # end
                end
            end
        end

        # update the temperature -
        T = T*(1-α);
        
        # should we stay in the loop? (or should we go ...)
        if (T < 0.001)
            is_ok_to_continue = false; # we are done!
        end
    end

    if (verbose == true)
        println("SA routine: Stopped with best loss: ", best_loss);
    end

    # return the best parameters we found so far
    return θ̂;
end