

include ./hack/help.mk


UID:=$(shell id -u)
GID:=$(shell id -g)
PWD:=$(shell pwd)


ELM_OPTS=-it --rm -v "$(PWD):/code" -w "/code" -v "$(PWD)/.elm_home/tmp/.elm:/tmp/.elm" -e "HOME=/tmp" -u "$(UID):$(GID)"


.PHONY: clear-cache
clear-cache:
	rm -rf /tmp/.elm
	rm -rf $(PWD)/elm-stuff
	rm -rf $(PWD)/.elm_home


.PHONY: cli
cli: ##@dev provide docker based environment with elm tooling
	docker run $(ELM_OPTS) -p 8000:8000 --entrypoint="bash" codesimple/elm:0.19


.PHONY: build
build: ##@build builds js file from elm source files
	docker run $(ELM_OPTS) --entrypoint="bash" codesimple/elm:0.19 -c "elm make src/Main.elm --output=dist/build.js --optimize"


#"HOME=/tmp/"
#"ELM_HOME=/tmp/.elm"
.PHONY: serve
serve: ##@dev runs node server which serves elm apps on port :8000
	docker run $(ELM_OPTS) -p 9977:9977 codesimple/elm:0.19 reactor --port 9977

