# --- PRIVATE API BELOW HERE -------------------------------------------------------------------------------------- #
function _learn(features::Array{<:Number,2}, labels::Array{<:Number,1}, algorithm::MyPerceptronClassificationModel; 
    maxiter::Int64 = 100, verbose::Bool = false)

    # get data from the algorithm -
    β = algorithm.β;
    m = algorithm.mistakes;
    is_ok_to_continue = true;
    loop_counter = 1;
    error_counter = 0;
    
    # main loop -
    β̂ = copy(β); # copy the coefficients
    while (is_ok_to_continue == true) 
        
        error_counter = 0; # initialize the error counter
        for i ∈ eachindex(labels) # for each training pair
            
            x = features[i,:]; # feature vector (n+1) x 1
            y = labels[i]; # classification -1,1
            
            # check: misclassified?
            if (y*sum(β̂.*x)) ≤ 0
                β̂ = β̂ .+ y*x;
                error_counter+=1        
            end
        end # end training loop for

        # should we stay in the loop? (or should we go ...)
        if (loop_counter >= maxiter || error_counter ≤ m)
            is_ok_to_continue = false; # we are done!
        else
            is_ok_to_continue = true; # we are not done yet!
            loop_counter+=1; # increment the loop counter
        end
    end

    # print the results if verbose is true -
    if (verbose == true)
        println("Stopped after number of iterations: ", loop_counter, ". We have number of errors: ", error_counter);
    end
    
    # update the model -
    algorithm.β = β̂; # update the coefficients

    # return -
    return algorithm;
end

function _learn(features::Array{<:Number,2}, labels::Array{<:Number,1}, algorithm::MyLogisticRegressionClassificationModel; 
    maxiter::Int64 = 100, verbose::Bool = false)
    
    # get data from the algorithm -
    θ = algorithm.θ; # parameters
    α = algorithm.α; # learning rate
    ϵ = algorithm.ϵ; # stopping criterion
    L = algorithm.L; # loss function
    is_ok_to_continue = true;
    loop_counter = 1;
    number_of_parameters = size(θ,1); # how many parameters?
    number_of_instances = size(features,1); # how many instances?

    # main loop -
    θᵢ = copy(θ); # copy the coefficients, initial guess
    error = nothing;
    while (is_ok_to_continue == true && loop_counter ≤ maxiter) 
        
        # initialize the gradient -
        ∇L = zeros(size(θᵢ));
        
        # compute the gradient -
        for i ∈ eachindex(labels) # for each training pair
            
            x = features[i,:]; # feature vector (n+1) x 1
            y = labels[i]; # classification -1,1
            h = 0.01*(1/number_of_parameters)*norm(θᵢ); # step size
            
            # compute the gradient -
            ∇L = ∇L .+ ∇f(L, x, y, θᵢ, h); # call forward diff approx of derivative
        end # end training loop for
        
        # update the coefficients -
        θᵢ = θᵢ .- α*∇L;
        
        # should we stay in the loop? (or should we go ...)
        error = 0.0;
        for i ∈ 1:number_of_instances
            x = features[i,:]; # feature vector (n+1) x 1
            y = labels[i]; # classification -1,1
            error += L(x, y, θᵢ);
        end

        # should we stay in the loop? (or should we go ...)
        if (error ≤ ϵ)
            is_ok_to_continue = false; # we are done!
        else
            is_ok_to_continue = true; # we are not done yet!
            loop_counter+=1; # increment the loop counter
        end
    end

    # print the results if verbose is true -
    if (verbose == true)
        println("Stopped after number of iterations: ", loop_counter, ". We have error: ", error);
    end

    # update the algorithm -
    algorithm.θ = θᵢ; # update the coefficients

    # return -
    return algorithm;
end

function _learn(features::Array{<:Number,2}, labels::Array{<:Number,1}, algorithm::MyLogisticRegressionSimulatedAnnealingClassificationModel; 
    maxiter::Int64 = 100, verbose::Bool = false)

    # get data from the algorithm -
    θ = algorithm.θ; # initial parameters
    L = algorithm.L; # loss function
    α = algorithm.α; # cooling rate

    # call the simulated annealing algorithm -
    θ̂ = copy(θ); # copy the coefficients
    θ̂ = _simulated_annealing(features, labels, L, θ̂, α, maxiter = maxiter, verbose = verbose);

    # update the algorithm -
    algorithm.θ = θ̂; # update the coefficients

    # return -
    return algorithm;
end

function _classify(features::Array{<:Number,2}, algorithm::Union{MyLogisticRegressionClassificationModel, MyLogisticRegressionSimulatedAnnealingClassificationModel})

    # initialize -
    number_of_examples = size(features,1); # number of rows
    labels = zeros(number_of_examples,2);
    β = algorithm.θ;

    for i ∈ 1:number_of_examples
        x = features[i,:];
        labels[i,1] = (1)/(1+exp(-dot(x,β))); # probability y = 1;
        labels[i,2] = (1)/(1+exp(dot(x,β))); # probability y = -1;
    end

    return labels;
end

function _classify(features::Array{<:Number,2}, algorithm::MyPerceptronClassificationModel)
    return sign.(features*algorithm.β);
end
# --- PRIVATE API ABOVE HERE -------------------------------------------------------------------------------------- #

# --- PUBLIC API BELOW HERE --------------------------------------------------------------------------------------- #
"""
    learn(features::Array{<:Number,2}, labels::Array{<:Number,1}, algorithm::AbstractClassificationAlgorithm; 
        maxiter::Int64 = 100, verbose::Bool = false)

The function learns a classification model from the data provided using the algorithm specified.
This is a wrapper function that calls the internal function `_learn` whose implementation is algorithm-specific.

### Arguments
- `features::Array{<:Number,2}`: the features.
- `labels::Array{<:Number,1}`: the labels.
- `algorithm::AbstractClassificationAlgorithm`: the algorithm to use to learn the model.

### Returns
- the updated algorithm model.
"""
function learn(features::Array{<:Number,2}, labels::Array{<:Number,1}, algorithm::AbstractClassificationAlgorithm; 
    maxiter::Int64 = 100, verbose::Bool = false)
    
    # call the internal function, and return the updated algorithm model
    return _learn(features, labels, algorithm, maxiter = maxiter, verbose = verbose);
end

"""
    classify(features::Array{<:Number,2}, algorithm::AbstractClassificationAlgorithm)
"""
function classify(features::Array{<:Number,2}, algorithm::AbstractClassificationAlgorithm)
    return _classify(features, algorithm);
end

"""
    confusion(actual::Array{Int64,1}, model::Array{Int64,1}) -> Array{Int64,2}

The function computes the confusion matrix for the classification model.

### Arguments
- `actual::Array{<:Number,1}`: the actual labels.
- `model::Array{<:Number,1}`: the model estimated labels.

### Returns
- a 2x2 confusion matrix.
"""
function confusion(actual::Array{<:Number,1}, model::Array{<:Number,1})::Array{Int64,2}

    # compute the confusion matrix -
    number_of_test_examples = size(actual,1);
    confusion_matrix = zeros(Int64,2,2);
    y = actual;
    ŷ = model;
    
    # True positive: TP (cancer)
    counter = 0;
    for i ∈ 1:number_of_test_examples
        if (y[i] == 1 && ŷ[i] == 1)
            counter+=1;
        end
    end
    confusion_matrix[1,1] = counter;

    # False negative: FN
    counter = 0;
    for i ∈ 1:number_of_test_examples
        if (y[i] == 1 && ŷ[i] == -1)
            counter+=1;
        end
    end
    confusion_matrix[1,2] = counter;

    # False position: FP
    counter = 0;
    for i ∈ 1:number_of_test_examples
        if (y[i] == -1 && ŷ[i] == 1)
            counter+=1;
        end
    end
    confusion_matrix[2,1] = counter;

    # True negative: TN
    counter = 0;
    for i ∈ 1:number_of_test_examples
        if (y[i] == -1 && ŷ[i] == -1)
            counter+=1;
        end
    end
    confusion_matrix[2,2] = counter;

    # return -
    confusion_matrix
end

# --- PUBLIC API ABOVE HERE --------------------------------------------------------------------------------------- #