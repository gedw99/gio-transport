# gio-transport

This is an exploration of ways we can create reusable transports for gio ( golang gui ) and non golang gui with Golang Server infrastructure.


Transport and Bus are heavily related because as highlighed below we need to run anywhere which leads to needing to send messages inside, across and between process boundaries. 

The initial proposal is here: https://github.com/gedw99/gio-proposals/blob/e1669bda78d4147dea6ad28a521d94f12e6dc62d/modularity/README.md#bus


## Problem space.

A GUI system wants to be fast and as such it needs to not get blocked by calls to the IO computation.

Golang routines and TinyGo ( via LLVM ) compilation dont work, because  WASM threading is not mature enough to parse golang coroutines into WASM threads. So i personally feel that a formal foreground and background ( web workers and or service workers ) is the required solution and hence why a BUS is required. 


GIO supports Web, Desktop, Mobile and Apple TV.  This Web Workers pattern, if formalsied into a API,  can be reused for Web and Non Web ( Desktop and Mobile ) GUI. Thus providing Developers a runtime agnostic system.

Current state of Art is git.sr.ht/~gioverse/skel, whcih provides a scheduler.
- Example: https://github.com/npillmayer/giocomp
  - https://github.com/npillmayer/giocomp/blob/main/components/comp.go#L9 is a reusable Component type.

## Solution

A Type structure is needed to describe the Messages and API.

A Bus is needed that can move the messages.

Along with the Bus, you need Transport or Bridges to abstract that bus over the different Process boundaries / Servers.

## Scope of Runtimes environment and Languages

A protobuf is a nice language agnostic basis. 
- Its transport independent so we can use it in Client <--> Client, Client <--> Server and Server <--> Server scenarios.
- Its language independent, so we can support any language ( JS, GO, RUST, Java) 
- Importantly it provides Schema Evolution, so that a change to the Types that the Bus uses does not break consumers of the Bus.



## Topologies

So we have a bus at each topology level: 

- Client <--> Client

- Client <--> Server

- Server <--> Server

### Client <--> Client

Is useful for Modularity in that you can send a message to another package that you have no knowldge of. Its designed for decoupling of Application to allow reuse and hence Modularity. 

The Web Service worker patterns uses of Message Passing ( https://developer.mozilla.org/en-US/docs/Web/API/Client/postMessage ) could provide compile target agnostics , allowing this bus feature to work cross platform on Web and NON Web runtime targets.

The Web Worker pattern is is the process isolation boundary ( https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API ) and describes where the background prcoess runs. You can use this with or with Service Workers. 

The Service Workers ( a architype of Web Workers are relevant because they provide a Proxy to the Server for data storage, caching and A2HS ( https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Add_to_home_screen ) providing the ability to install Web apps and offline first class apps onto Desktops and Mobiles. 

So you can see how the message passing bus needs to accomodate this Client <--> topology for Webworkers and Service Workers.


--- 

### Client <--> Server

Using various protocols, is designed to provide a generic pattern for Unidirectional messge push in a decoupled and modular way, allowing maximum reuse and developer productivity. In so doing it would provide compile target agnostics to this feature.

Examples:

https://git.sr.ht/~whereswaldon/pointstar/tree/master/item/client/url.go
- a nice simple example using websockets for passing data betwene a GUI Web and NON Web GUI and a Golang Server using websockets, without a formal bus. 

https://centrifugal.dev/docs/transports/overview
- Transpots under consideration: GRPC, SSE, HTTP Streaming, GRPC, NATS
- Just really an example of possible transports. 

---

### Server <--> Server

Using various protocols, is designed to provide a generic way to pass messages between any server process.

Runtimes are WASI, and OS Native.

Examples:

Cloud events is a vendor neutral approach. 

---

### Server <--> Server && Server <--> Client && Client <--> Client

Combines all these topolgies to connect together in a seamless way. 

Examples:

NATS BUS with Siot: https://github.com/simpleiot/simpleiot/search?q=nats

## Uses Cases


1. Typescript and go (wasm) for web 

- SO GUI developers can use Typescript ( next.js, React ) with the Golang ( WASM ) handling logic, IO, storage.
- Example: Golang WASM and typescript interoperating over the "vmware transport bridge"
  - https://github.com/vmware/transport-go/pull/46
  - Libs:
    - https://github.com/vmware/transport-go
    - https://github.com/vmware/transport-typescript
- Example: Golang WASM and JS interoperating over a custom bridge.
  - https://github.com/tmc/goloz
  - GRPC && GRPC-Web as the Client to Server transport. 
  - GRPC-Web Client is compiled to Goalng WASM use web sockets thanks to the custom GRPC-Web implemenation that uses nhooyr.io/websocket
  - GRPC Client can still use tcp. 
    - Libs:
      - https://github.com/tmc/grpc-websocket-proxy


--- 

2. Typescript and Golang ( Non WASM ) for Desktop and Mobiles Webviews

- So you can reuse the same typescript GUI on not just Web, but also Mobile and Desktop. Its essentially like the cordova concept ( originally from Adobe if i recall ) which you may know of.


- For Desktop and Mobile, https://github.com/Inkeliz/gowebview provides the runtime suport. 
- A Bus between the Golang and Webview is needed.

---

3. Golang GUI ( no js aspects ) utilising GIO. 

- GIO is 100% golang and compiles for Web, Mobile, Desktop and Apple tv.
- It also compiles on Mobile to shared object, and so is able to be included in a tranditionl IOS or Android GUI.
- It has Material Design widgets. 
- It has Native and Web support using https://github.com/gioui/gio-x, for things like Notifications, but also:
  - hyperlinks: https://github.com/Inkeliz/giohyperlink 
  - storage: https://github.com/Inkeliz/giostorage
  - credentials: https://github.com/Inkeliz/giocredentials
- spec that highlights this: https://github.com/gedw99/gio-proposals/blob/main/modularity/README.md#bus is a very short description of it. It quite old too.
- Bus that uses NATS for Client ( web or non web) to Server is here:
  - Golang WASM client: https://github.com/matrix-org/dendrite/blob/master/cmd/dendritejs/main.go
  - Golang Server: https://github.com/matrix-org/dendrite/blob/master/cmd/dendrite-monolith-server/main.go

3. Server to Server computation using WASI and a NATS bus
- Hooking up the GUI ( WASM and Mobile and Desktop ) with the Server ( WASI )
- Example of aspects of that : https://github.com/suborbital/sat/blob/main/go.mod
  - It uses NATS Jetstream for WASI to WASI.










