FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Base utilities
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    wget \
    gnupg \
    python3 \
    python3-pip \
    python3-venv \
    git \
    file \
    unzip \
    p7zip-full \
    jq \
    tcpdump \
    tshark \
    net-tools \
    iputils-ping \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Python tooling (REMnux core equivalents)
RUN pip3 install --no-cache-dir \
    pefile \
    oletools \
    capstone \
    yara-python \
    pycryptodomex \
    flare-floss \
    vivisect \
    requests \
    rich

# FLOSS Python
RUN pip3 install --no-cache-dir flare-floss

# YARA
RUN apt-get update && apt-get install -y yara

# Didier Tools
WORKDIR /usr/local/bin/
RUN wget https://didierstevens.com/files/software/pdf-parser_V0_7_8.zip \
   && wget http://didierstevens.com/files/software/pdfid_v0_2_8.zip \
   && wget https://didierstevens.com/files/software/oledump_V0_0_75.zip \
   && unzip pdf-parser_V0_7_8.zip \
   && rm -rf pdf-parser_V0_7_8.zip \
   && chmod a+x pdf-parser.py \
   && unzip pdfid_v0_2_8.zip \
   && rm -rf pdfid_v0_2_8.zip \
   && chmod a+x pdfid.py \
   && unzip oledump_V0_0_75.zip \
   && rm -rf oledump_V0_0_75.zip \
   && chmod a+x oledump.py

RUN ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/local/bin/pdfid.py /usr/local/bin/pdfid \
    && ln -s /usr/local/bin/oledump.py /usr/local/bin/oledump \
    && ln -s /usr/local/bin/pdf-parser.py /usr/local/bin/pdf-parser \
    && ln -s /usr/local/bin/xlmdeobfuscator /usr/local/bin/xlmdeob      

WORKDIR /analysis
