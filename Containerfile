FROM ubuntu:latest as base
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y git sudo

# Disable password for sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN useradd -m niklas
RUN usermod -aG sudo niklas
USER niklas
WORKDIR /home/niklas
RUN mkdir /home/niklas/git

#RUN git clone https://github.com/NVolcz/dotFiles.git git/dotFiles
COPY --chown=niklas ./ ./git/dotFiles

FROM base as bootstrapped
RUN "./git/dotFiles/bootstrap.sh"


#RUN chmod +x /root/git/dotFiles/bootstrap.sh
#RUN chmod +x /root/git/dotFiles/test/docker-test.sh

#RUN mkdir -p /root/.local/bin/
#RUN mkdir -p /root/.local/share/applications/
#RUN mkdir /root/.config

