"""
    build(modeltype::Type{MyPerceptronClassificationModel}, 
        data::NamedTuple) -> MyPerceptronClassificationModel

The function builds a perceptron classification model from the data provided.

### Arguments
- `modeltype::Type{MyPerceptronClassificationModel}`: the type of the model to build.
- `data::NamedTuple`: the data to use to build the model.

The `data::NamedTuple` must have the following fields:
- `parameters::Vector{Float64}`: the coefficients of the model.
- `mistakes::Int64`: the number of mistakes that are are willing to make.

### Returns
- a perceptron classification model.
"""
function build(modeltype::Type{MyPerceptronClassificationModel}, 
    data::NamedTuple)::MyPerceptronClassificationModel

    # build an empty model -
    model = modeltype();
    β = data.parameters;
    m = data.mistakes;
    
    # set the data -
    model.β = β;
    model.mistakes = m;

    # return -
    return model;
end

"""
    build(modeltype::Type{MyLogisticRegressionClassificationModel}, 
        data::NamedTuple) -> MyLogisticRegressionClassificationModel

The function builds a logistic regression classification model from the data provided.

### Arguments
- `modeltype::Type{MyLogisticRegressionClassificationModel}`: the type of the model to build.
- `data::NamedTuple`: the data to use to build the model.

The `data::NamedTuple` must have the following fields:
- `parameters::Vector{Float64}`: the coefficients of the model.

### Returns
- a logistic regression classification model.
"""
function build(modeltype::Type{MyLogisticRegressionClassificationModel}, 
    data::NamedTuple)::MyLogisticRegressionClassificationModel

    # build an empty model -
    model = modeltype();
    β = data.parameters;
    α = data.learning_rate
    L = data.loss_function
    ϵ = data.ϵ
    
    # set the data -
    model.θ = β;
    model.α = α;
    model.L = L;
    model.ϵ = ϵ;

    # return -
    return model;
end

function build(modeltype::Type{MyLogisticRegressionSimulatedAnnealingClassificationModel}, 
    data::NamedTuple)::MyLogisticRegressionSimulatedAnnealingClassificationModel

    # build an empty model -
    model = modeltype();
    θ = data.parameters;
    ϵ = data.ϵ;
    α = data.cooling_rate;
    L = data.loss_function;
    
    # set the data -
    model.θ = θ;
    model.ϵ = ϵ;
    model.α = α;
    model.L = L;

    # return -
    return model;
end