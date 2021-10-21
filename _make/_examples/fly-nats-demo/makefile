# https://github.com/fly-apps/6pn-demo-chat/

include ./../../fly.mk

LIB_NAME=6pn-demo-chat

FLY_APP=gedw99-6pn-demo-chat

print:
	$(MAKE) fly-print

dep:
	git clone https://github.com/fly-apps/6pn-demo-chat/

dep-os:
	$(MAKE) fly-dep

init:
	cd $(LIB_NAME) && $(FLY_BIN) auth login
launch:
	cd $(LIB_NAME) && $(FLY_BIN) launch $(FLY_APP) --import example-fly.toml

	# fly init YOURAPPNAME --import example-fly.toml
