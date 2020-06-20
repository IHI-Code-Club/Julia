# # Julia @ IHI Code Club

# ## The REPL
#
# Julia comes with a
# [REPL](https://docs.julialang.org/en/v1/stdlib/REPL/#The-Julia-REPL-1)
# (Read-Eval-Print-Loop) where you can interactively run commands.

2 + 2
#-
sin(3.14)

# You can define simple functions with the one-line syntax

f(x) = 3 * x ^ 2

# or with the longer, equivalent, syntax

function g(x)
    return 3 * x ^ 2
end
#-
f(5 - 4)
#-
g(5 - 4)
#-

# You can assign a value to a variable, like the speed of light in vacuum in m/s
# (underscores are ignored, but make the number more readable)

c = 299_792_458
#-
f(c)

# Use the semicolon `;` at the end of the line to hide the output of the result

c ^ 4;

# Do you note something strange?  Can you guess what happened?  Read the
# [Frequently Asked
# Questions](https://docs.julialang.org/en/v1/manual/faq/#faq-integer-arithmetic-1)
# in the documentation to know more.
#
# Julia has full support for Unicode

println("人人生而自由,在尊严和权利上一律平等。他们赋有理性和良心,并应以兄弟关系的精神相对待。")

# including in identifiers (tip: you can use LaTeX-like commands `\alpha + TAB`
# and `\beta + TAB` to get these symbols)

α = 1.2
β = 3.4
α / β

# or even emoji, if your font supports them (tip: use `\:apple: + TAB` and
# `\:tangerine: + TAB` for these).  Who said you can't sum apples and oranges?

🍎 = 5
🍊 = 7
🍎 + 🍊

# Julia has by default other REPL modes: the package manager mode (that you can
# enter with `]`), the shell-mode (enter with `;`) and the help mode (enter with
# `?`).

# ## Arrays and statistics
#
# Julia has native support for arrays

v = [7.43, 5.05, 1.7, 6.68]
#-
length(v)
#-
v[1]
#-
v[3]
#-
4 .* v .- 2.5

# You can generate random numbers with
# [`rand`](https://docs.julialang.org/en/v1/stdlib/Random/#Base.rand) and
# [`randn`](https://docs.julialang.org/en/v1/stdlib/Random/#Base.randn):

rand()
#-
randn()

# or random arrays by specifying the dimension:

r = randn(1000)
A = rand(4, 4)

# Statistical functions are defined in the
# [`Statistics.jl`](https://docs.julialang.org/en/v1/stdlib/Statistics/)
# standard library

using Statistics

mean(r)
#-
median(r)
#-
std(r)
#-
quantile(r, 0.01)

# More advanced statistical functions are provided in third-party packages, like
# [`StatsBase.jl`](https://github.com/JuliaStats/StatsBase.jl).

# ## Rock-paper-scissors: playing with multiple dispatch
#
# We can write a simple implementatio of the popular hand game
# rock-paper-scissors in less than 10 lines of code in Julia.  This
# implementation will give use the opportunity to have a closer look to one of
# Julia's main features: [multiple
# dispatch](https://docs.julialang.org/en/v1/manual/methods/#Methods-1).
#
# *Note: this section is based on the blog post [Rock–paper–scissors game in
# less than 10 lines of
# code](https://giordano.github.io/blog/2017-11-03-rock-paper-scissors/)*.
#
# ### The game
#
# Here we go:

abstract type Shape end
struct Rock     <: Shape end
struct Paper    <: Shape end
struct Scissors <: Shape end
play(::Type{Paper}, ::Type{Rock}) = "Paper wins"
play(::Type{Paper}, ::Type{Scissors}) = "Scissors wins"
play(::Type{Rock}, ::Type{Scissors}) = "Rock wins"
play(::Type{T}, ::Type{T}) where {T<: Shape} = "Tie, try again"
play(a::Type{<:Shape}, b::Type{<:Shape}) = play(b, a); # Commutativity

# That's all.  Nine lines of code, as promised.
#
# ### Play the game
#
# Now that we’ve implemented the game we can play it in the Julia REPL:

play(Paper, Scissors)
#-
play(Rock, Rock)
#-
play(Rock, Paper)

# There was no explicit method for the combination of arguments `Rock`-`Paper`,
# but the commutative rule has been used here.

# ## Data science with Julia
#
# ### Dataframes
#
# [`DataFrames.jl`](https://github.com/JuliaData/DataFrames.jl) provides the
# tools to work with tabular data.  This section is largely based on [its
# documentation](http://juliadata.github.io/DataFrames.jl/v0.21/)

using DataFrames
df = DataFrame(A = 1:4, B = ["M", "F", "F", "M"])

# Columns can be accessed via `df.col`, `df."col"`, `df[:, "col"]` and and a few
# more options not mentioned here for brevity.

df.A
#-
df[:, "A"]
#-
names(df)

# #### Constructing from another table type
#
# `DataFrames.jl` can also interact with other packages:
#
# ```julia
# df = DataFrame(a=[1, 2, 3], b=[:a, :b, :c])
#
# # write DataFrame out to CSV file
# CSV.write("dataframe.csv", df)
#
# # store DataFrame in an SQLite database table
# SQLite.load!(df, db, "dataframe_table")
#
# # transform a DataFrame through Query.jl package
# df = df |> @map({a=_.a + 1, _.b}) |> DataFrame
# ```
#
# #### Working with dataframes
#

df = DataFrame(A = 1:2:40, B = repeat(1:4, inner=5), C = 1:20)
#-
describe(df)
#-
df[7:12, :]
#-
df[:, [:A, :B]]
#-
df[6:10, [:A, :C]]
#-
df[iseven.(df.B), :]
#-
df[df.A .> 20, :]
#-
df[(df.A .> 20) .& (iseven.(df.B)), :]

# This is only the tip of what you can do with `DataFrames.jl`.  For a more
# in-depth guide, besides the official documentation of the package check out
# this [tutorial on
# DataFrames](https://github.com/bkamins/Julia-DataFrames-Tutorial)
#
# An alternative stack to deal with tabular data is the
# [Queryverse](https://www.queryverse.org/).
#
# #### Dataframes and CSV files
#
# For reading and writing tabular data from CSV and other delimited text files,
# use the [`CSV.jl`](https://github.com/JuliaData/CSV.jl) package.
#
# ```julia
# using CSV
# # Read a dataframe from a CSV file
# df = DataFrame(CSV.File(input))
# # Create a dataframe to be written to a CSV file
# df = DataFrame(x = 1, y = 2)
# CSV.write(output, df)
# ```
#
# ### Databases
#
# There are a few packages to access different flavours of databases:
#
# * [`MySQL.jl`](https://github.com/JuliaDatabases/MySQL.jl),
# * [`ODBC.jl`](https://github.com/JuliaDatabases/ODBC.jl),
# * [`SQLite.jl`](https://github.com/JuliaDatabases/SQLite.jl),
# * [`JDBC.jl`](https://github.com/JuliaDatabases/JDBC.jl),
# * [`LibPQ.jl`](https://github.com/invenia/LibPQ.jl).

# ## Coming from other languages?
#
# Julia has got you covered!  It has a good interoperability with other
# programming languages, which makes it easier to move to Julia from other
# languages but still keep using your current toolbox.
#
# *Note: all languages are different from each other and of course Julia is no
# special, so make sure to read the [noteworthy differences between Julia and
# the other
# languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/)*.
#
# ### C/Fortran
#
# If you are C or Fortran programmer, calling function in a C/Fortran libraries
# (in particular, the libraries should be ["shared
# libraries"](https://en.wikipedia.org/wiki/Library_(computing)#Shared_libraries))
# is as easy as running the
# [`ccall`](https://docs.julialang.org/en/v1/base/c/#ccall) function, without
# writing wrapper code.  For example, with this command we can run the function
# `getenv` in the standard C library

path = ccall(:getenv, Cstring, (Cstring,), "SHELL")

# As you may expect, dealing with C is rather low-level.  The output is quite
# unreadable for a human being, but can be converted to a standard string with

unsafe_string(path)

# I will not indulge more into interfacing C libraries, but those interested can
# read more in the [Calling C and Fortran
# Code](https://docs.julialang.org/en/v1/manual/calling-c-and-fortran-code/)
# section of the manual.
#
# ### Python and R
#
# Calling Python libraries is made simple by the
# [`PyCall.jl`](https://github.com/JuliaPy/PyCall.jl) package.  Simple packages
# requires little or no effort, The classes in the Python standard library or in
# the popular NumPy package are naturally translated to their equivalent Julia
# data types, to make the experience as seamless as possible:

using PyCall

const math = pyimport("math")
const np = pyimport("numpy")

math.sin(pi) - sin(math.pi)

# Here we have mixed Python and Julia functions and variables: Python `math.sin`
# and `math.pi` with `sin` and `pi` from Julia.  The syntax used by PyCall
# closely resembles that of Python.
#
# Non-standard Python packages can also be called with PyCall and they mostly
# work without extra work, but you may encounter some quirks.  For example, we
# can play a bit with [`pandas`](https://pandas.pydata.org/):

const pd = pyimport("pandas")

df = pd.DataFrame(Dict(:age=>[27, 29, 27], :name=>["James", "Jill", "Jake"]))
#-
df.describe()
#-
df.age

# You can note in this case that the custom Python class used by `pandas` shows
# here an annoying `PyObject` text in the output.  If you want to use a more
# integrated interface to `pandas`, consider the package
# [`Pandas.jl`](https://github.com/JuliaPy/Pandas.jl).
#
# To call R package, check out
# [`RCall.jl`](https://github.com/JuliaInterop/RCall.jl).
#
# ![RCall example](https://github.com/JuliaInterop/RCall.jl/raw/c5d8de4145e2b3b3cf2a35502c0a80590209254e/ggplot.png "RCall example")

# ## What about plotting?
#
# That's a great question!  Plotting is not a field where Julia shines
# currently.  There are several nice plotting packages, with many different
# features, but a common problem is compilation latency, leading to coining the
# term "time to first plot".  I will list here some of the options:
#
# * [`PyPlot.jl`](https://github.com/JuliaPy/PyPlot.jl): interface to Python's
#   Matplotlib, this is reasonably quick
# * [`Plots.jl`](https://github.com/JuliaPlots/Plots.jl): this is one of the
#   most popular plotting packages in Julia, as it can use to many different
#   plotting backends always using the same interface.  It is also extensible:
#   it allows to define "recipes" for custom Julia types.  On the other end, it
#   has a large compilation latency.  After loading the package, the first plot
#   in a session can take ~20-30 seconds, but this is improving!
# * [`Makie.jl`](https://github.com/JuliaPlots/Makie.jl): it aims to replace
#   `Plots.jl` in the future, but it has similar issues in terms of initial plot
# * [`Gadfly.jl`](https://github.com/GiovineItalia/Gadfly.jl): heavily inspired
#   by "The Grammar of Graphics" book.  Kind of quick
# * [`UnicodePlots.jl`](https://github.com/Evizero/UnicodePlots.jl): simple
#   plots directly in terminal.  Super fast!

# ## More advanced topics
#
# So far we have relatively simple applications of Julia, but if you are
# interested you can have a look to more advanced ones.  Even though the
# environment is young when compared with established languages like Python and
# R, many high-quality packages are being used to do avanced scientific
# research.  Here is a summary of some of the most popular ones, classified by
# topic:
#
# * Automatic differentiation:
#   [`ChainRules.jl`](https://github.com/JuliaDiff/ChainRules.jl),
#   [`ForwardDiff.jl`](https://github.com/JuliaDiff/ForwardDiff.jl),
#   [`ReverseDiff.jl`](https://github.com/JuliaDiff/ReverseDiff.jl),
#   [`Zygote.jl`](https://github.com/FluxML/Zygote.jl)
# * Differential equations:
#   [`DifferentialEquations.jl`](https://github.com/SciML/DifferentialEquations.jl)
#   and many other packages in the [`SciML`](https://github.com/SciML)
#   organisation on GitHub
# * GPU programming: [`CUDA.jl`](https://github.com/JuliaGPU/CUDA.jl) for NVidia
#   GPUs, [`AMDGPUnative.jl`](https://github.com/JuliaGPU/AMDGPUnative.jl) for
#   AMD ones
# * Machine learning: [`Flux.jl`](https://github.com/FluxML/Flux.jl),
#   [`Knet.jl`](https://github.com/denizyuret/Knet.jl),
#   [`MLJ.jl`](https://github.com/alan-turing-institute/MLJ.jl)
# * Mathematical optimisation: [`JuMP.jl`](https://github.com/jump-dev/JuMP.jl)
# * Probabilistic programming: [`Gen.jl`](https://github.com/probcomp/Gen.jl),
#   [`Turing.jl`](https://github.com/TuringLang/Turing.jl)

# ## Beyond scientific computing
#
# Julia is mainly employed for scientific computing, but more and more users are
# realising that its syntax and packages are equally good for general
# programming, too. The [Administrative Scripting with
# Julia](https://github.com/ninjaaron/administrative-scripting-with-julia#id4)
# repository is a guide about how to use Julia for system administration.  This
# also rightly points out the shortcomings of Julia in this field: its
# JIT-compilation model favours launching a single long-running script, rather
# than many small ones: the latter case can be exceedingly slow as compilation
# of each script may take *much* longer than actually running them.  Many ways
# to tackle the issue of the compilation latency are currently being worked out.

# ## Environments and reproducibility
#
# A great attention is dedicated to reproducibility in the Julia community.  The
# built-in package manager, `Pkg.jl`, allows you to create environments, which
# are controlled by two files:
#
# * `Project.toml`: it records the list of the packages required in the
#   environment — the direct dependencies — and you can also optioanlly specify
#   the compatibility bounds of these packages, according to [Semantic
#   Versioning](https://semver.org/)
# * `Manifest.toml`: it takes a snapshot al *all* packages in the environment,
#   with the exact version number of all packages — both direct and indirect
#   dependencies of the environment.
#
# When compatibility bounds are properly used in the `Project.toml` file, it
# lets you instantiate at any point in the future a "compatible" environment —
# "compatible" in the SemVer sense.  The `Manifest.toml`, instead, lets you
# recreate exactly the same environment.
#
# In its top-level, this repository provides an example of
# [`Project.toml`](./Project.toml) with the full specification of compatible
# versions for all non-standard libraries.  The accompanying
# [`Manifest.toml`](./Manifest.toml) lists all packages in the environment.
# This, for example, allows [binder](https://mybinder.org/) to generate a
# container with the same set of packages as me.
#
# You can read more about [working with
# environments](https://julialang.github.io/Pkg.jl/v1/environments/) in the
# documentation of `Pkg.jl`.

# ## Notebooks and literate programming
#
# Julia is fully supported by the popular Jupyter notebooks.  In fact, the "Ju"
# in its names stands for "Julia", alongside with Python and R.  Julia kernels
# for Jupyter notebooks are provided by the
# [`IJulia.jl`](https://github.com/JuliaLang/IJulia.jl) package.
#
# [`Pluto.jl`](https://github.com/fonsp/Pluto.jl) is a lightweight alternative
# to Jupyter notebooks.  Pluto notebooks are reactive, which means that the
# values of the cells don't depend on their order of execution, which is a
# common gripe in Jupyter notebooks.
#
# ![Pluto notebook](https://raw.githubusercontent.com/fonsp/Pluto.jl/580ab811f13d565cc81ebfa70ed36c84b125f55d/demo/plutodemo.gif "Pluto notebook")
#
# There are different tools for [literate
# programming](https://en.wikipedia.org/wiki/Literate_programming) in Julia.
# This tutorial was created with
# [`Literate.jl`](https://github.com/fredrikekre/Literate.jl), which allows you
# to generate a Markdown file and a Jupyter noetbook from a simple commented
# Julia script.  Another option is
# [`Weave.jl`](https://github.com/JunoLab/Weave.jl).  Similar to Pweave, knitr,
# R Markdown, and Sweave, `Weave.jl` supports multiple input and output formats,
# including HTML and PDF.

# ## Keep in touch
#
# There are several ways to engage the Julia community online:
#
# * [Julia Discourse](https://discourse.julialang.org/), the discussion forum
# * [Slack workspace](https://slackinvite.julialang.org/)
# * [Zulip](https://julialang.zulipchat.com/register/)
# * [`#JuliaLang`](https://twitter.com/hashtag/JuliaLang) hashtag on Twitter
# * [JuliaLang](https://www.youtube.com/user/JuliaLanguage) channel on YouTube,
#   where many tutorials and most JuliaCon talks are collected
# * Watch online [JuliaCon 2020](https://juliacon.org/2020/)!
#
# You can find more resources in the [community
# page](https://julialang.org/community/) of the official website.
