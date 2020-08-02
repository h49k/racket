FROM ubuntu:focal

RUN apt-get update && apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		netbase \
        software-properties-common \
	&& rm -rf /var/lib/apt/lists/*

RUN set -ex; \
	if ! command -v gpg > /dev/null; then \
		apt-get update; \
		apt-get install -y --no-install-recommends \
			gnupg \
			dirmngr \
		; \
		rm -rf /var/lib/apt/lists/*; \
	fi

RUN set -eux \
    && add-apt-repository ppa:plt/racket && apt-get update \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        racket \
    && rm -rf /var/lib/apt/lists/*

