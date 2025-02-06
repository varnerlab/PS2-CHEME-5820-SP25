abstract type AbstractClassificationAlgorithm end

"""
    mutable struct MyPerceptronClassificationModel <: AbstractClassificationAlgorithm

A mutable struct that represents a perceptron classification model.

### Fields
    - `β::Vector{Float64}`: coefficients
    - `mistakes::Int64`: number of mistakes that are are willing to make
"""
mutable struct MyPerceptronClassificationModel <: AbstractClassificationAlgorithm
    
    # data -
    β::Vector{Float64}; # coefficients
    mistakes::Int64; # number of mistakes that are are willing to make

    # empty constructor -
    MyPerceptronClassificationModel() = new();
end

"""
    mutable struct MyLogisticRegressionClassificationModel <: AbstractClassificationAlgorithm

A mutable struct that represents a logistic regression classification model.

### Fields
    - `θ::Vector{Float64}`: coefficients
    - `α::Float64`: learning rate
    - `ϵ::Float64`: convergence criterion
    - `L::Function`: loss function
"""
mutable struct MyLogisticRegressionClassificationModel <: AbstractClassificationAlgorithm
    
    # data -
    θ::Vector{Float64}; # coefficients
    α::Float64; # learning rate
    ϵ::Float64; # convergence criterion
    L::Function; # loss function

    # empty constructor -
    MyLogisticRegressionClassificationModel() = new();
end

"""
    mutable struct MyLogisticRegressionSimulatedAnnealingClassificationModel <: AbstractClassificationAlgorithm

A mutable struct that represents a logistic regression classification model.

### Fields
    - `θ::Vector{Float64}`: coefficients
    - `α::Float64`: learning rate
    - `ϵ::Float64`: convergence criterion
    - `L::Function`: loss function
"""
mutable struct MyLogisticRegressionSimulatedAnnealingClassificationModel <: AbstractClassificationAlgorithm
    
    # data -
    θ::Vector{Float64}; # coefficients
    ϵ::Float64; # convergence criterion
    α::Float64; # cooling rate
    L::Function; # loss function

    # empty constructor -
    MyLogisticRegressionSimulatedAnnealingClassificationModel() = new();
end