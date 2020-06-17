# Julia @ IHI Code Club

## Pre-requisites

If you can't (or don't want to ;-) install Julia on your machine, you will
probably be able to try it during the live coding session on
[Binder](https://mybinder.org/).  If you're happy to try it directly on your
machine, follow the instructions below.

### Installing Julia

Download the current stable version of Julia (v1.4.2 as of 2020-06-24) for your
operating system from the [official website](https://julialang.org/downloads/).
Read the [platform-specific
instructions](https://julialang.org/downloads/platform/) should you need more
guidance.

### IDEs and text editors

Many popular IDEs and text editors have plugins for Julia.  The two most popular
ones are

* [Julia extension](https://www.julia-vscode.org/) for [Visual Studio
  Code](https://code.visualstudio.com/)
* [Juno](https://junolab.org/), extension for [Atom](https://atom.io/)

If you don't have any preference, I slightly recommend Visual Studio Code over
Atom, as it has a better support overall.  If you already have your favourite
development environment, go for it!  There will likely be a plugin to add
support for Julia.

### Installing the required packages

*NOTE: these instructions are in evolution, make sure to check them again one or
two days before the meeting.*

During the live coding session we'll use some third-party packages.  Julia comes
with a built-in package manager, which you can use to install them.  Start
Julia, either in the terminal or in your favourite IDE, from the REPL you can
enter the package manager mode with the `]` key, then run the following command:

```
add CSV, DataFrames, PyCall
build PyCall
```

You can then exit the package manager mode by pressing backspace -- think about
it like deleting the `]` key you used to enter the package manager mode.

Alternatively, you can install the packages also with the following command
directly in the REPL (this also works in Jupyter notebooks)

```julia
using Pkg
Pkg.add(["CSV", "DataFrames", "PyCall"])
Pkg.build("PyCall")
```

After you have successfully installed and built the packages, make sure they
work as expected with the following command in the REPL:

```julia
using CSV, DataFrames, PyCall
```

Brew a cup of coffee while you wait for the precompilation of the packages to
finish :-)

## Further resources

Many useful learning resources are listed on [the official
website](https://julialang.org/learning/).  You may also be interested in

* [Official Julia documentation](https://docs.julialang.org/en/v1/)
* [A tutorial on
  `DataFrames.jl`](https://github.com/bkamins/Julia-DataFrames-Tutorial/)
* [Queryverse](https://www.queryverse.org/), a Julia data science stack
* [Julia - Learn X in Y](https://learnxinyminutes.com/docs/julia/), a quick
  Julia cheatsheet
* [Julia By Example](https://juliabyexample.helpmanual.io/), another cheatsheet
