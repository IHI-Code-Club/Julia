using Literate

Literate.notebook(joinpath(@__DIR__, "julia.jl"), dirname(@__DIR__))
Literate.markdown(joinpath(@__DIR__, "julia.jl"), dirname(@__DIR__); documenter=false)
