# gio-transport

This is a project that has a GIOUI golang client and a  NATS Serve, with the communication between them using the NATS Protocol.

NATS provides 2 ways to connect that we need to account for.

- TCP for naive cleitn like GIO Desktop and GIO Mobile.
- WebSockets 



The GUI Client has a simple example game that uses web sockets, in order to act as a Test Harness.


## Why ?

Linking up GIOUI with NATS provides the following:

- Load balancing is free with no additional components like load balancers
- Failover is free with no additional components like load balancers
- Geo failover and fallback is free with no additional components like global dns
- Long running connections are used for microservices speeding up connection handling
- NATS support canary deploys, gradual deploys, traffic shaping or more
- NATS, being subject and interest based, does not need any additional infrastructure for service discovery


## _make folder

This folder has all the different makefiles needed to run golang, gio, caddy, and a few other things.  

Its all designed to be reusable.

TODO: adjsut them to work for Linux ( for Mindaugas), and Windows.

**Examples:**

To inspect the setup of your root makefile:

``` make go-print ``` tells you the gio setup

``` make gio-print ``` tells you the gio setup

``` make caddy-print ``` for example tells you the caddy setup

---

To install any dependencies and templates:

``` make gio-dep ``` sets up gio tooling for cross compiling to WASM, Desktop and Mobile.

``` make caddy-dep ``` sets up caddy tooling and templates, so you can run under HTTPS locally to have a proper environment.

## whereswaldon__pointstar folder

A GIO game that uses websockets and runs on Web, Desktop and Mobile.

Make file is setup to use the makefile in the **_make** folder