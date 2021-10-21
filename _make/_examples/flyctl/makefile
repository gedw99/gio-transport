
LIB_NAME=flyctl

print:

dep:
	git clone git@github.com-gedw99:gedw99/flyctl.git
dep-delete:
	rm -rf $(LIB_NAME)

mod:
	cd $(LIB_NAME) && go mod tidy

build:
	cd $(LIB_NAME) && go build -o $(GOPATH)/bin/flyctl .

install:
	cd $(LIB_NAME) && go install .
	which flyctl

install-remote:
	go install github.com/gedw99/flyctl@latest
	which flyctl