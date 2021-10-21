# GIO-MAKE

Provides standardised and reusable makefiles for working with gio proejcts in general.

## Why ?


These makefile includes follow certain conventions to:

- Ensure CI and Local Dev work the same. A github workflow calls the exact same makefiles that you use localy. No Split brain. 

- Provide conventions that are extensible. Each .mk does a specific thing, allowing you to put any logic or customisations in your own root makefile where you need to do anything differently.

## Examples

Various example are in. https://github.com/gedw99/gio-make-examples

GIO
- https://github.com/gedw99/gio-make-examples/gioui__gio-example


## Conventions

There are some conventions in all this that you can follow to stay out of trouble.



## Print variable

Each makefile includes has a ```<prefix>-print``` that echo's the used variables back to you. Use it to see what MAKE variables you need in your makefile.

For example:

In [goi.mk](go.mk), you have the following variables only to worry about:

```GOI_SRC_NAME``` 

```GOI_SRC_FSPATH```


So, those variables need to exist in your own **makefile**

For example:

```GIO_SRC_NAME=goi-projectname``` 

```GIO_SRC_FSPATH=$(PWD)$(GIO_SRC_NAME)```


## Dep

Each make file includes has a ```<prefix>-dep``` that ensures any dependency it needs are installed.

This ensures both CI and Local Dev always have the dependencies and they are the same in each environment.

It also will put templates into your root folder that aid in working with that technology. 

For example in [gio.mk](gio.mk), it will ensure that the gogio compile tool is installed. The version can be reflected from the go.modules per project.

It will also put templates into your root that are useful when working with gio projects.

TODO: look into incorporating bingo. EX: https://github.com/grafana/grafana/tree/main/.bingo


## Creating your own .mk files

Use a Prefix to isolate each make target of each makefile respectively.

For example:

In [go.mk](go.mk), you have:
- ```go-build```
- ```go-run```, etc

in [git.mk](git.mk) you have:
- ```git-repo-clone-origin```
- ```git-repo-clone-upstream```, etc