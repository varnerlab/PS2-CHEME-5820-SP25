# setup paths -
const _ROOT = pwd();
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_DATA = joinpath(_ROOT, "data");

# flag to check if the include file was called -
const _DID_INCLUDE_FILE_GET_CALLED = true;

# check do we have a Manifest.toml file?
using Pkg;
if (isfile(joinpath(_ROOT, "Manifest.toml")) == false) # have manifest file, we are good. Otherwise, we need to instantiate the environment
    Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();
end

# load external packages -
using StatsPlots
using Plots
using Colors
using Statistics
using LinearAlgebra
using Distances
using PrettyTables
using Random
using DataFrames
using CSV
using FileIO
using Test

# load my own packages -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Data.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));
include(joinpath(_PATH_TO_SRC, "FiniteDifference.jl"));
include(joinpath(_PATH_TO_SRC, "SimulatedAnnealing.jl"));