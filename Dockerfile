FROM ubuntu:focal

ARG RACKET_VARSION=7.8
ARG PACKAGE=racket-${RACKET_VARSION}-src-builtpkgs.tgz

RUN set -eux \
	&& apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		apt-utils \
		curl \
		build-essential \
	&& cd / \
	&& curl -s -OL https://mirror.racket-lang.org/installers/${RACKET_VARSION}/${PACKAGE} \
	&& tar -zxf ${PACKAGE} \
	&& cd /racket-${RACKET_VARSION}/src \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install \
	&& raco pkg install --auto racket-langserver \
	&& cd / \
	&& apt-get -y remove --purge build-essential \
	&& apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /racket-${RACKET_VARSION} \
	&& rm -f racket-${RACKET_VARSION}src-builtpkgs.tgz

