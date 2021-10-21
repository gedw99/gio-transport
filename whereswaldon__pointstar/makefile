# https://git.sr.ht/~whereswaldon/pointstar

LIB_NAME=pointstar

print:
	$(MAKE) go-print
	$(MAKE) gio-print
	$(MAKE) caddy-print

dep:
	rm -rf $(LIB_NAME)
	git clone https://git.sr.ht/~whereswaldon/pointstar


MAKE_FSPATH=./../_make
include $(MAKE_FSPATH)/help.mk
include $(MAKE_FSPATH)/go.mk
include $(MAKE_FSPATH)/gio.mk
include $(MAKE_FSPATH)/caddy.mk

GO_SRC_NAME=$(LIB_NAME)
GO_SRC_FSPATH=$(PWD)/$(GO_SRC_NAME)

GIO_SRC_NAME=client
GIO_SRC_FSPATH=$(PWD)/$(LIB_NAME)/$(GIO_SRC_NAME)

CADDY_SRC_FSPATH=$(PWD)

FLY_APP=gedw99-gio-example.pointstar

dep-os:
	# assume you have golang installed
	$(MAKE) go-dep

	$(MAKE) gio-dep
	$(MAKE) caddy-dep

## GO modules ops ...

mod-update:
	$(MAKE) go-mod-update
mod-tidy:
	$(MAKE) go-mod-tidy

## Build targets ...

this-web-buildrun:
	# builds and runs all in one for WEB
	cd $(LIB_NAME) && $(MAKE) all

	# Web Socket running at:
	# ws://localhost:8080/ws
	# http://localhost:8080/ws

	# WASM GIO gui running at:
	# http://localhost:8080/

this-web-tinygo:
	# not working. Gio and tinygo are working on it still..
	cd $(LIB_NAME)/client && tinygo build -o wasm.wasm -target wasm ./main.go 

this-web-serve:
	$(MAKE) caddy-run
	# Runs a basic caddy proxy server with TLS 
	# https://localhost:8443/

this-desk-build:
	# NOT working right now. I think just needs correct PList .
	$(MAKE) gio-desk-mac-build 

this-desk-run:
	# run the gio client at terminal
	open $(GIO_BUILD_DARWIN_PATH)

this-desk-bundle-open:
	# opens the app bundle.
	open $(GIO_BUILD_FSPATH)







