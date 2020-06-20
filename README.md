# Julia @ IHI Code Club

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/IHI-Code-Club/Julia/master?filepath=julia.ipynb)

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
add DataFrames, PyCall
build PyCall
```

You can then exit the package manager mode by pressing backspace -- think about
it like deleting the `]` key you used to enter the package manager mode.

Alternatively, you can install the packages also with the following command
directly in the REPL (this also works in Jupyter notebooks)

```julia
using Pkg
Pkg.add(["DataFrames", "PyCall"])
Pkg.build("PyCall")
```

After you have successfully installed and built the packages, make sure they
work as expected with the following command in the REPL:

```julia
using DataFrames, PyCall
```

Brew a cup of coffee while you wait for the precompilation of the packages to
finish :-)

### Optional dependencies

If you want to run the Jupyter notebbok, you have to install the Julia kernel
provided by the [`IJulia.jl`](https://github.com/JuliaLang/IJulia.jl) package.
To install and build it, either enter the package manager mode in the REPL with
`]` and run the commands

```
add IJulia
build IJulia
```

or run the coomands

```julia
using Pkg
Pkg.add("IJulia")
Pkg.build("IJulia")
```

## How to follow the live coding session

To follow the live coding session on your computer, clone the git repository
locally with the command

```
git clone https://github.com/IHI-Code-Club/Julia
```

You then have many options, depending on your preferred setup.  You can follow
what we'll do during the live coding session in either the MarkDown document
[`julia.md`](./julia.md), the Jupyter notebook [`julia.ipynb`](./julia.ipynb),
or the Julia script [`src/julia.jl`](./src/julia.jl).  The former two documents
have been automatically generated from the latter one using a package for
literate programming called
[`Literate.jl`](https://github.com/fredrikekre/Literate.jl).

### Using the REPL

If you simply want to use Julia's REPL, start it and type the commands that
we'll be running.  You can also copy them from any of the three documents
mentioned above.

### Using an IDE

#### Juno

If you decided to use Juno, open [`src/julia.jl`](./src/julia.jl) in Atom.  You
can evaluate a line of code or a selection of lines with `Ctrl + Enter`, the
result of the evaluation will shown inline.  For more information, read the
[Basic Usage](http://docs.junolab.org/latest/man/basic_usage/) instructions in
the Juno documentation.

#### Visual Studio Code

The Julia extension for Visual Studio Code allows you to evaluate the code
directly in the editor, similarly to what Juno does.  Open the file
[`src/julia.jl`](./src/julia.jl) and hit `Alt + Enter` to evaluate the current
code block and move to the next line, or use `Ctrl + Enter` to simply evaluate
the current line.  Refer to the [Running
Code](https://www.julia-vscode.org/docs/stable/userguide/runningcode/) section
of the manual for more information.

### Running the Jupyter notebook locally

If you enjoy using Jupyter notebooks, you may want to run
[`julia.ipynb`](./julia.ipynb).  Remember to install the `IJulia.jl` package as
described above.

You can run the notebook as usual with

```
jupyter /PATH/TO/julia.ipynb
```

or in the Julia REPL with the commands

```julia
using IJulia
notebook(detached=true)
```

then browse to the directory where this repository is and open the notebook.

### Running the Jupyter notebook on Binder

If you didn't have the possibility to install locally Julia and the package
suggested for the live coding session, you may still have a chance: you can run
[the Jupyter notebook on
Binder](https://mybinder.org/v2/gh/IHI-Code-Club/Julia/master?filepath=julia.ipynb).
This solution, however, depends on the availability of Binder resources at the
time of live coding: many users connected at the same time may cause a slow down
of the remote notebook.

## Further resources

Many useful learning resources are listed on [the official
website](https://julialang.org/learning/).  You may also be interested in

* [Official Julia documentation](https://docs.julialang.org/en/v1/)
* [Julia - Learn X in Y](https://learnxinyminutes.com/docs/julia/), a quick
  Julia cheatsheet
* [Julia By Example](https://juliabyexample.helpmanual.io/), another cheatsheet
