# TimescaleDB taxi data

This project contains supporting code for the TimescaleDB video on Dreams of Code's YouTube: https://www.youtube.com/watch?v=ruUlK6zRwS8

## Devcontainer

If you use devpod or GitHub Codespaces, there is a `.devcontainer` folder with a Dockerfile that will build a devcontainer for you. It will setup everything from with Postgres and TimescaleDB as well as migrate the tables and hypertables.

When you have everything setup, just SSH into the container through devpod:

```sh
devpod ssh timescaledb-taxidata
```

To check your Timescale installation, `psql` to your database and introspect it with `\dt` and you should see your `trips` and `trips_hyper` tables:
```sh
root ➜ ~ $ sudo -u postgres psql
  could not change directory to "/root": Permission denied
  psql (15.4 (Debian 15.4-2.pgdg120+1))
  Type "help" for help.

  postgres=# \c tsdb
  You are now connected to database "tsdb" as user "postgres".
  tsdb=# \dt
                List of relations
  Schema |       Name        | Type  |  Owner
  --------+-------------------+-------+----------
  public | cab_types         | table | postgres
  public | data_loaded       | table | postgres
  public | schema_migrations | table | postgres
  public | trips             | table | postgres
  public | trips_hyper       | table | postgres
  (5 rows)

  tsdb=#
```

### Running the python scripts

Since Python 3 is readily available inside the devcontainer, ssh into it and run the scripts:

```sh
devpod ssh timescaledb-taxidata

  root ➜ ~ $ cd /workspaces/timescaledb-taxidata/
  root ➜ /workspaces/timescaledb-taxidata (main) $ python3 src/download.py
  ...

  root ➜ /workspaces/timescaledb-taxidata (main) $ python3 src/load-2023.py # load only 2023 parquet files into the database
  ...

  root ➜ /workspaces/timescaledb-taxidata (main) $ python3 src/load.py # load all the files into the database (will take pretty long)
```
---

## Requirements

In order to use this project, you'll need to set up the following tools:

### TimescaleDB database

This project uses TimescaleDB as it's primary data store. There are a number
of ways to get a timescale DB instance up and running.

#### Timescale Managed

This is the easiest approach to get started, and it's free for 30 days. This
allows you to easily try timescale before commiting to any purchase or use case.

You can get the managed version of timescale on their [website](https://www.timescale.com/?utm_source=dreams-of-code&utm_medium=youtube&utm_campaign=kol-q3-2023&utm_content=homepage)

#### Timescale local

If you want to run it locally, you can do so by extending postgres. Timescale
have some great [documentation](https://docs.timescale.com/self-hosted/latest/install/)
on how to do that.

#### Timescale Docker

Finally, another great approach is to use docker. The
[documentation](https://docs.timescale.com/self-hosted/latest/install/installation-docker/)
providews instructions here as well. Be warned that if you're running docker
on a non linux machine, it will be slower due to having to run through a
hypervisor.

### Python3

Python3 is used as the primary language for downloading data and then
loading it into timescaleDB. The recommended version of python to use is
3.11.x or greater.

#### macOS

To install on macOS, one can use homebrew to do so using the following commands

```
$ brew install python
```

#### Arch Linux

```
$ sudo pacman -S python
```

### Debian

```
$ sudo apt install python
```

### psql

In the video we interact with the database using psql, which is a command line
tool provided by postgres.

#### macOS

To install it for macOS, you can use homebrew

```
$ brew install postgresql
```

#### Arch Linux

```
$ sudo pacman -S postgresql
```

### migrate-cli

[migrate](https://github.com/golang-migrate/migrate) is used for database migrations. To install it, you can do so one of two
ways, depending on if you have go installed on your system or not.

#### Go

```
$ go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
```

#### macOS

```
$ brew install migrate
```

#### Arch Linux

```
$ yay -S migrate
```
