# I take no responsibility for bloated Docker images. Proceed at your own risk. :)

FROM rust as cairo

RUN apt-get update && apt-get install -y curl gzip tar git

RUN curl -L -o scarb.tar.gz https://github.com/software-mansion/scarb/releases/download/v2.8.4/scarb-v2.8.4-x86_64-unknown-linux-gnu.tar.gz

RUN tar -xvf scarb.tar.gz

RUN mv scarb-v2.8.4-x86_64-unknown-linux-gnu/bin /usr/local/bin/scarb

RUN chmod +x usr/local/bin/scarb

ENV PATH=$PATH:/usr/local/bin/scarb


FROM cairo

WORKDIR /app

COPY ./flex_cairo .

ENTRYPOINT ["scarb", "cairo-run"]

