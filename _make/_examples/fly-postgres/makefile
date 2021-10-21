# https://github.com/fly-apps/postgres-ha

include ./../../fly.mk
FLY_APP=gedw99-postgres-ha

LIB_NAME=postgres-ha

print:
	$(MAKE) fly-print

dep:
	git clone https://github.com/fly-apps/postgres-ha
	#fly init YOURAPPNAME --import example-fly.toml

dep-os:
	$(MAKE) fly-dep

fly-init:
	cd $(LIB_NAME) && flyctl init

init:
	$(FLY_BIN) auth login
	$(FLY_BIN) init $(FLY_APP) --import example-fly.toml
