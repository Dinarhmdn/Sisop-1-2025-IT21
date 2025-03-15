#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

# database
USER_DB="data/player.csv"
SALT_KEY="garem"

# buat database jika belum ada
if [[ ! -f "$USER_DB" ]]; then
    echo -e "${YELLOW}User database not found. Creating database...${NC}"
    mkdir -p "$(dirname "$USER_DB")" && touch "$USER_DB"
    echo "email,username,password_hash" > "$USER_DB"
    echo -e "${GREEN}Database created successfully.${NC}"
fi

# validasi email
validate_email() {
    local email="$1"
    if [[ "$email" == *"@"* && "$email" == *"."* ]]; then
        return 0
    else
        return 1
    fi
}

# validasi password
validate_password() {
    local password="$1"
    if [[ ${#password} -lt 8 || ! "$password" =~ [A-Z] || ! "$password" =~ [a-z] || ! "$password" =~ [0-9] ]]; then
        return 1
    else
        return 0
    fi
}

# cek argumen register
if [[ $# -ne 3 ]]; then
    echo -e "${YELLOW}Usage: register.sh <email> <username> <password>${NC}"
    exit 1
fi

user_email="$1"
user_username="$2"
user_password="$3"

# validasi email
if ! validate_email "$user_email"; then
    echo -e "${RED}Error: Invalid email format!${NC}"
    exit 1
fi

# validasi password
if ! validate_password "$user_password"; then
    echo -e "${RED}Error: Password must be at least 8 characters long, contain uppercase, lowercase, and a number!${NC}"
    exit 1
fi

# cek apakah email sudah terdaftar
if grep -q "^$user_email," "$USER_DB"; then
    echo -e "${RED}Error: Email is already registered!${NC}"
    exit 1
fi

# Hashing password
hashed_password=$(echo -n "$SALT_KEY$user_password" | sha256sum | awk '{print $1}')

# simpan data ke database
echo "$user_email,$user_username,$hashed_password" >> "$USER_DB"
echo -e "${GREEN}Registration successful! Welcome, $user_username 🎉${NC}"
