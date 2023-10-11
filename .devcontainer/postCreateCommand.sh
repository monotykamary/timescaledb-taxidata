#!/bin/bash

yes | pip3 install --break-system-packages -r requirements.txt
service postgresql start

sudo -u postgres psql << EOF
ALTER USER postgres WITH PASSWORD 'postgres';
CREATE database tsdb;
\c tsdb;
CREATE EXTENSION IF NOT EXISTS timescaledb;
EOF

make migrate-hypertable
