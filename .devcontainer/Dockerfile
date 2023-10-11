FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt update && \
    apt install -y xz-utils gnupg postgresql-common apt-transport-https lsb-release wget python3 python3-pip golang

RUN yes '' | sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
RUN echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list
RUN wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo apt-key add -

RUN apt update && \
    apt install -y postgresql-15 timescaledb-2-postgresql-15 postgresql-client-15

RUN yes 'y' | timescaledb-tune

RUN echo "PATH=$PATH:/root/go/bin" >> /root/.profile
RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
