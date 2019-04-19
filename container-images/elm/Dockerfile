

# --info: only for local development
# TODO: merge with elm-ci-build image, possible bec multi stage and use from stage stuff


# --info: multi-stage build


# --stage: 1 - build


FROM node:10.15.3


RUN npm install -g elm@0.19.0-bugfix6 --unsafe-perm=true
RUN npm install -g uglify-js@3.5.4
RUN npm install -g elm-live@3.4.0


ENV WORKDIR /workdir
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}


# COPY dependencie document (elm.json ?!) ...


# RUN install ELM_HOME dependencies..???


# COPY src


# RUN elm make src/Main.elm --output elm.js --optimize && \
#     uglifyjs elm.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters=true,keep_fargs=false,unsafe_comps=true,unsafe=true,passes=2' --output=elm.js && uglifyjs elm.js --mangle --output=elm.js


# --stage: 2 - nginx


#FROM nginx alpine ...

