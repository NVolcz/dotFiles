FROM ubuntu:latest

RUN apt-get update && apt-get install -y git

RUN mkdir -p /root/git

ARG CACHE_DATE=not_a_date

#RUN git clone https://github.com/NVolcz/dotFiles.git git/dotFiles
COPY ./ /root/git/dotFiles

RUN chmod +x /root/git/dotFiles/bootstrap.sh
RUN chmod +x /root/git/dotFiles/test/docker-test.sh

RUN mkdir -p /root/.local/bin/
RUN mkdir -p /root/.local/share/applications/
RUN mkdir /root/.config

RUN /bin/bash -c "source /root/git/dotFiles/bootstrap.sh"
