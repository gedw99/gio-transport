# fly

# they give global NATS and POST
# NATS: 
# - https://fly.io/docs/app-guides/nats-cluster/
# - https://fly.io/docs/app-guides/6pndemochat/
# POST: 
# - https://fly.io/docs/reference/postgres/
# - https://fly.io/docs/app-guides/postgres/

# Pgrok can be run there: https://inlets.dev/blog/2021/07/07/inlets-fly-tutorial.html


# FLY

# https://github.com/superfly/flyctl
FLY_BIN=flyctl
FLY_BIN_VERSION=v0.0.244

# https://fly.io/docs/flyctl/integrating/

# The one below is named "dev" in their console at: # https://web.fly.io/user/personal_access_tokens
export FLY_ACCESS_TOKEN=Q3m-KvWd9apo4HjSDCbTrZUxf86YurxUuzmNZnEQdoI
FLY_APP=?123?

# Override variables
FLY_EX_NAME=?
FLY_EX_PATH=FILEPATH?/$(FLY_EX_NAME)



## fly print, outputs all variables for the fly compiler
fly-print:
	@echo
	@echo ### FLY ###
	@echo FLY_BIN: $(FLY_BIN)
	@echo FLY_BIN: $(FLY_BIN_VERSION)
	@echo installed fly at : $(shell which $(FLY_BIN))
	@echo ---
	@echo
	@echo FLY_ACCESS_TOKEN: $(FLY_ACCESS_TOKEN)
	@echo FLY_APP: $(FLY_APP)
	@echo FLY_EX_PATH: $(FLY_EX_PATH)
	@echo FLY_EX_NAME: $(FLY_EX_NAME)
	@echo
	

## fly dep gets the fly cli and installs it.
fly-dep:
	@echo
	@echo installing FLY tool
	brew install superfly/tap/flyctl
	@echo installed fly at : $(shell which $(FLY_BIN))
	# does not work: https://github.com/superfly/flyctl/issues/538
	#go install github.com/superfly/flyctl@$(FLY_BIN_VERSION)
	# requires adding to path and i am lazy
	#curl -L https://fly.io/install.sh | sh
	

