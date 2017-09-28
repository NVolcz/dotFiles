FROM ubuntu:latest

RUN apt-get update && apt-get install -y git

RUN mkdir git

ARG CACHE_DATE=not_a_date

#RUN git clone https://github.com/NVolcz/dotFiles.git git/dotFiles
ADD ./ git/dotFiles

RUN chmod +x git/dotFiles/bootstrap.sh

RUN /bin/bash -c "source git/dotFiles/bootstrap.sh"
