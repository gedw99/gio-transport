

# TODO
# - GOENV like here: https://github.com/shanna/entxid-test/blob/master/Makefile, so make things cleaner 
# - Docker like here: https://github.com/shanna/entxid-test/blob/master/Makefile,


# Deps
GO_BIN=go
GO_MOD_UPGRADE=go-mod-upgrade

# Override variables
GO_SRC_NAME=?
GO_SRC_FSPATH=?FILEPATH?/$(GO_SRC_NAME)

# Constant variables
GO_BUILD_FSNAME=gobuild

# Computed variables
GO_ARCH=$(shell go env GOARCH)
GO_OS=$(shell go env GOOS)
GO_BUILD_FSNAME=gobuild

# Computed variables
GO_BUILD_FSPATH=$(GO_SRC_FSPATH)/gobuild
GO_BUILD_WINDOWS_PATH=$(GO_BUILD_FSPATH)/windows/$(GO_SRC_NAME).exe
GO_BUILD_DARWIN_PATH=$(GO_BUILD_FSPATH)/darwin/$(GO_SRC_NAME)
GO_BUILD_LINUX_PATH=$(GO_BUILD_FSPATH)/linux/$(GO_SRC_NAME)

## Prints the variables used.
go-print:
	@echo 
	@echo --- GO ---

	@echo Deps:
	@echo GO_BIN: $(GO_BIN) installed go at : $(shell which $(GO_BIN))
	@echo GO_MOD_UPGRADE: $(GO_MOD_UPGRADE) installed go-mod-upgrade at : $(shell which $(GO_MOD_UPGRADE))
	@echo
	@echo Override variables:
	@echo GO_SRC_NAME:				$(GO_SRC_NAME)
	@echo GO_SRC_FSPATH:			$(GO_SRC_FSPATH)
	@echo
	@echo Constant variables:
	@echo GO_BUILD_FSNAME: 			$(GO_BUILD_FSNAME)
	@echo
	@echo Computed variables:
	@echo GO_ARCH:					$(GO_ARCH)
	@echo GO_OS:					$(GO_OS)
	@echo GO_BUILD_WINDOWS_PATH:	$(GO_BUILD_WINDOWS_PATH)
	@echo GO_BUILD_DARWIN_PATH:		$(GO_BUILD_DARWIN_PATH)
	@echo GO_BUILD_LINUX_PATH:		$(GO_BUILD_LINUX_PATH)
	@echo 
	
## Installs all tools
go-dep:
	@echo
	@echo -- Installing go
	# Not needed for development or CI.
	#brew install go
	@echo installed go at : $(shell which $(GO_BIN))

	@echo
	@echo -- Installing go-mod-upgrade
	go install github.com/oligot/go-mod-upgrade@latest
	@echo installed go-mod-upgrade at : $(shell which $(GO_MOD_UPGRADE))

## Reconciles golang packages
go-mod-tidy:
	@echo
	@echo -- Visiting:		$(GO_SRC_FSPATH)
	cd $(GO_SRC_FSPATH) && go mod tidy
	
## Upgrades golang packages interactively
go-mod-upgrade:
	# See: https://github.com/shanna/entxid-test/blob/master/Makefile#L19
	@echo
	@echo -- Visiting:		$(GO_SRC_FSPATH)
	cd $(GO_SRC_FSPATH) && go-mod-upgrade
	cd $(GO_SRC_FSPATH) && go mod tidy
	cd $(GO_SRC_FSPATH) && go mod verify

## Runs the code
go-run:
	cd $(GO_SRC_FSPATH) && go run .

## Generates and builds the code
go-build:
	cd $(GO_SRC_FSPATH) && go generate ./...
	# switch for OS
	cd $(GO_SRC_FSPATH) && go build -o $(GO_BUILD_DARWIN_PATH) .

## Builds and immediately runs the binary
go-buildrun: go-build
	# switch for OS
	cd $(GO_SRC_FSPATH) && ./$(GO_BUILD_DARWIN_PATH)

## Deletes all builds
go-build-clean:
	cd $(GO_SRC_FSPATH) && rm -rf $(GO_BUILD_FSNAME)

