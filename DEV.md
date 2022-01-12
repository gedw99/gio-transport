# gio-transport




This is a project that has a GIOUI golang client that uses websockets and a  NATS Serves, with the communication between them using the NATS Protocol.


The GUI Client has a simple example game that uses web sockets, in order to act as a Test Harness.

NATS provides 2 ways to connect that we need to account for.

- TCP for naive client such as GIO Desktop and GIO Mobile.
- WebSockets for web client such as GIO WASM.

## Why ?

Linking up GIOUI with NATS provides the following:

- Load balancing is free with no additional components like load balancers
- Failover is free with no additional components like load balancers
- Geo failover and fallback is free with no additional components like global dns
- Long running connections are used for microservices speeding up connection handling
- NATS support canary deploys, gradual deploys, traffic shaping or more
- NATS, being subject and interest based, does not need any additional infrastructure for service discovery

Caddy provides the following:

- Virtual hosting of the GIO GUI WASM and Golang Servers ( where you can adn any game logic you need for example)

- Auth and Authz using Caddy Portal ( see below ) to any virtual hosts

- Proxying of the HTTP and Web socket connections between Clients ( such as the GIO GUI) and NATS Server. Note that the NATS Server can be embedded in any Golang Server or can be run standalone.

- Proxying of the HTTP and Web socket connections between Clients ( such as the GIO GUI) and Servers such as the Goalng Servers. In this case the PointStar Server. 

## How ?

The following ideas are to be explored, to see what is the best and easiest approach:

1. Pointstar websockets might work with the NATS Websockets, without any caddy.

In Pointstar what we dont know yet if the https://github.com/nhooyr/websocket client websockets are compatible with the  https://github.com/nats-io/nats.go/blob/main/ws.go web sockets server. This is the first thing to try !!

2. Integration of Caddy Auth with NATS Auth. 

In PointStar, the user logs in using GIO, and there is no Auth enforcement. NATS can create users and accounts ( accounts are like roles btw ), and so since we use NATS for all communications, we shoudl try out using Caddy Auth with NATS Auth. The details of this are explained below.

3. Integration of Caddy and NATS HTTP and WebSockets 

By incorporating this a the Caddy level, all golang GUI and Goalng Servers get this for free, and so do not need to explicitly handle it in their own code. 
Its also a natural thing to do once you get Point 2 ( above ) working.


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

Make file is setup to use the makefile in the **_make** folder.

The aim is to get this working with NAST with no changes.

## Caddy

We can use caddy to perform:

- Auth and authz
- proxy the nats connection


## Caddy Auth

https://github.com/jaysonsantos/caddy-with-auth imports :

```
_ "github.com/greenpau/caddy-auth-jwt"
_ "github.com/greenpau/caddy-auth-portal"
```

This provides the auth and authz asepcts for http, and potentially nats.

We can embed a gio webview, so that we can load the Caddy Auth GUI inside the GIO app, to allow the user to login.

**Flow**

1. Caddy will see the call from the client to the Server

2. It will see if the header have a NATS jwt token

3. If will check the token against nats

4. If the token and nats operation are ok it will then proxy a web socket connection between the two.

4. If the auth / authz fails it will force the auth gui to open , so that the user can login.

5. TODO ....



## Caddy NATS

TODO: Add nats.mk to **_make** for easy manaement of nats.

https://github.com/ripienaar/nats-roundtripper provides http proxy

https://github.com/9glt/go-websockets-to-tcp-proxy provides Websockets proxy



## GIO WebView

We need to use a webview if we want to open the Caddy Potal Auth from the GIO GUI Web, Desktop and Mobile.

https://github.com/Inkeliz will do this. 
- It does not have full support for Mac and IOS yet.  The include for Mac is there at https://github.com/Inkeliz/gowebview/blob/master/libs/libwebview.dylib, but no main loader yet for it.


