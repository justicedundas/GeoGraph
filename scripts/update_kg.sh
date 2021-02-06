#!/bin/bash

# This script updates the knowledge graph



# downloald and prepare data files for KG construction
# $HOME/scripts/run_notebooks.sh 
python3 /home/main/src/python-files/import-data/geonames.py

#LOGDIR="$NEO4J_HOME"/import/logs/`date +%Y-%m-%d`
#mkdir -p "$LOGDIR"

# backup csv files
BACKUPDIR="$NEO4J_IMPORT"/backup/`date +%Y-%m-%d`
mkdir -p "$BACKUPDIR"
cp "$NEO4J_IMPORT"/*.csv "$BACKUPDIR"

# run Cypher scripts to upload the data into the knowledge graph
/home/main/src/scripts/run_cyphers.sh "$1"
