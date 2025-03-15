#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

DB_FILE="data/player.csv"
SALT="garem"

if [[ ! -f "$DB_FILE" ]]; then
    echo -e "${RED}Error: Database not found!${NC}"
    exit 1
fi

# parameter login
if [[ $# -ne 2 ]]; then
    echo -e "${YELLOW}Usage: login.sh <email> <password>${NC}"
    exit 1
fi

email="$1"
password="$2"

# hash password
hashed_input=$(echo -n "$SALT$password" | sha256sum | awk '{print $1}')

# cari email di database
if grep -q "^$email," "$DB_FILE"; then
    stored_hash=$(grep "^$email," "$DB_FILE" | cut -d',' -f3)

    if [[ "$hashed_input" == "$stored_hash" ]]; then
        username=$(grep "^$email," "$DB_FILE" | cut -d',' -f2)
        echo -e "${GREEN}Login Successfully! Welcome, $username 🎉${NC}"
        exit 0
    else
        echo -e "${RED}Error: Wrong password!${NC}"
        exit 1
    fi
else
    echo -e "${RED}Error: Email not registered!${NC}"
    exit 1
fi
