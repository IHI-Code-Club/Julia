using Literate

# Use the same value of ${SHELL} as on Binder
ENV["SHELL"] = "/bin/bash"

Literate.notebook(joinpath(@__DIR__, "julia.jl"), dirname(@__DIR__))
Literate.markdown(joinpath(@__DIR__, "julia.jl"), dirname(@__DIR__); documenter=false)
