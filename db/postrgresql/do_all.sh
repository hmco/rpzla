#!/bin/bash

# This creates the tables and view and uploads the sample-data

# Change your database and username ...

( cat create_tables.sql && cat create_views.sql ) | psql rpz rpz
( cd sample-data && ./web.sh && ./dns.sh ) | psql rpz rpz
