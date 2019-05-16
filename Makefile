

include ./hack/help.mk


UID:=$(shell id -u)
GID:=$(shell id -g)
PWD:=$(shell pwd)
DIRNAME:=$(shell basename "$(PWD)")


ifeq ($(UNAME_S),Linux)
	OS="LINUX"
	OPEN=x-www-browser
endif
ifeq ($(UNAME_S),Darwin)
	OS="OSX"
	OPEN=open
endif


ELM_CONTAINER_IMG_NAME=$(DIRNAME)_elm
ELM_DEFAULT_PORTS=-p 8000:8000
ELM_OPTS=-it --rm -v "$(PWD):/code" -w "/code" -v "$(PWD)/.elm_home/:/tmp/.elm" -e "ELM_HOME=/tmp/.elm" -u "$(UID):$(GID)"


# docker ps -a --no-trunc --filter name=^/nervous_robinson$
# docker ps | awk '{print $NF}' | grep -w foo
# docker ps -a | awk '{print $NF}' | grep -w "$containerName" | cat
.PHONY: setup
setup: ##@ulist
	#if container not running - docker run -d sleep infinity
	if [ -z `docker ps -q --no-trunc | grep $$(docker-compose ps -q cli)` ]; then \
		docker-compose up -d cli; \
	fi;


.PHONY: img-build
img-build: ##@ulist
	docker build --target build-dist \
	--stream -t $(ELM_CONTAINER_IMG_NAME) -f container-images/elm/Dockerfile .


.PHONY: clear-cache
clear-cache: ##@ulist
	rm -rf /tmp/.elm
	rm -rf $(PWD)/elm-stuff
	rm -rf $(PWD)/.elm_home


#TODO: ad `make setup`
#TODO: add check if container runs, if not build


# TODO: stand-alone cli -vs- attached cli
.PHONY: cli
cli: ##@dev provide docker based environment with elm tooling
	docker run $(ELM_OPTS) $(ELM_DEFAULT_PORTS) --entrypoint="bash" codesimple/elm:0.19


.PHONY: build
build: ##@build builds js file from elm source files
	docker run $(ELM_OPTS) --entrypoint="bash" codesimple/elm:0.19 -c "elm make src/Main.elm --output=dist/build.js --optimize"


#"HOME=/tmp/"
#"ELM_HOME=/tmp/.elm"
.PHONY: serve
serve: ##@dev runs node server which serves elm apps on port :8000
	docker run $(ELM_OPTS) -p 9977:9977 codesimple/elm:0.19 reactor --port 9977

