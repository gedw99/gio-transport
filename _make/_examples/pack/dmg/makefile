BIN_PATH=$(GOPATH)/bin
BIN_NAME=go-pack-dmg
BIN=$(BIN_PATH)/$(BIN_NAME)

# TODO: 
# make its own github repo.
# this is onyl doing mac. we need to ad windows.

print:
	@echo pack as dmg for mac


	@echo BIN: $(BIN)

build:
	go build -o $(BIN) . 

run:
	$(BIN)