VERSION = $(shell git describe --tags --always)

#.PHONY: generate
## generate
#generate:
#	@echo ">> generating code"
#	@$(GO) generate ./...
#	@$(MAKE) format
#
#
#.PHONY: build
## build
#build:
#	mkdir -p build/ && $(GO) build -ldflags "-X main.Version=$(VERSION)" -o build/ ./...
#
#
#.PHONY: run
## run
#run:
#	@$(MAKE) generate
#	@$(MAKE) common-config
#	@$(GO) run $(PREFIX)/cmd/server -conf $(PREFIX)/configs/config.toml
#


.PHONY: init
init:
	@echo ">> running init"
	@$(shell cd "./dockerfile" && for f in `ls .*.example`; do cp -f $$f $${f/%.example/}; done;)
	@$(shell cd "./dockerfile" && docker-compose down && docker-compose up -d)



.PHONY: config
config:
	@echo ">> running config"
	@$(shell cd "./configs" && for f in `ls *.example`; do cp -f $$f $${f/%.example/}; done)