

# --info: multi-stage build


# --stage: 1 - build: elm(js), css, html


FROM node:10.16.0 AS build-dist


ENV ELM_VERSION 0.19.0-no-deps
RUN npm install -g elm@${ELM_VERSION} --unsafe-perm=true
RUN npm install -g uglify-js@3.6.0
RUN npm install -g elm-live@3.4.1
RUN npm install -g purgecss@1.3.0


ENV WORKDIR /workdir
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}


# COPY dependencie document (elm.json ?!) ...
COPY elm.json ${WORKDIR}
COPY src ${WORKDIR}/src


# RUN install ELM_HOME dependencies..???
ENV ELM_HOME /tmp/.elm_home


# elm build
RUN mkdir -p ${WORKDIR}/dist
RUN elm make ${WORKDIR}/src/Main.elm --output ${WORKDIR}/dist/elm.js --optimize
RUN uglifyjs ${WORKDIR}/dist/elm.js --compress \
    'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' \
    --output=${WORKDIR}/dist/elm.min.js && \
    uglifyjs ${WORKDIR}/dist/elm.min.js --mangle --output=${WORKDIR}/dist/elm.min.js


# css build
# RUN purgecss --css <css> --content <content> [option]


# html build


# --stage: 2 - nginx


#FROM nginx alpine ...

