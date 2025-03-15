#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m'

clear

echo -e "${BLUE}==============================================="
echo -e "         ${YELLOW}Welcome to the ARCAEA System${NC}         "
echo -e "===============================================${NC}"

echo -ne "${GREEN}Initializing System.${NC}"
for i in {1..5}; do
    sleep 0.3
    echo -ne "█"
done
echo -e " ${GREEN}✔${NC}\n"

show_main_menu() {
    while true; do
        echo -e "${CYAN}-------------------------------------------------${NC}"
        echo -e " ${YELLOW}MAIN MENU:${NC}"
        echo -e "${CYAN}-------------------------------------------------${NC}"
        echo -e " ${GREEN}1.${NC} Register"
        echo -e " ${GREEN}2.${NC} Login"
        echo -e " ${RED}3.${NC} Exit"
        echo -e "${CYAN}-------------------------------------------------${NC}"

        # input user
        read -p " Choose an option [1-3]: " choice
        echo ""

        case $choice in
            1)
                echo -e "${YELLOW}→ Opening Register...${NC}\n"
                sleep 1
                
                # input user buat regis
                read -p "Input Email: " email
                read -p "Input Username: " username
                read -s -p "Input Password: " password
                echo ""
                
                # manggil script register
                bash register.sh "$email" "$username" "$password"

                sleep 2
                ;;
            2)
                echo -e "${YELLOW}→ Opening Login...${NC}\n"
                sleep 1
                
                # input user buat login
                read -p "Input Email: " email
                read -s -p "Input Password: " password
                echo ""

                # manggil script login
                bash login.sh "$email" "$password"
                login_status=$?

                if [ $login_status -eq 0 ]; then
                    sleep 1
                    show_user_dashboard
                else
                    echo -e "${RED}Login Failed! Incorrect email or password.${NC}\n"
                    sleep 2
                fi
                ;;
            3)
                echo -e "${RED}Exiting... See you next time!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice! Please try again.${NC}\n"
                sleep 1
                ;;
        esac
    done
}

show_user_dashboard() {
    while true; do
        echo -e "${CYAN}-------------------------------------------------${NC}"
        echo -e " ${YELLOW}USER DASHBOARD:${NC} (Logged in)"
        echo -e "${CYAN}-------------------------------------------------${NC}"
        echo -e " ${GREEN}1.${NC} Crontab Manager"
        echo -e " ${RED}2.${NC} Logout"
        echo -e "${CYAN}-------------------------------------------------${NC}"

        read -p " Choose an option [1-2]: " dashboard_choice
        echo ""

        case $dashboard_choice in
            1)
                echo -e "${YELLOW}→ Opening Crontab Manager...${NC}\n"
                sleep 1
                bash scripts/manager.sh
                ;;
            2)
                echo -e "${RED}Logging out...${NC}\n"
                sleep 1
                break
                ;;
            *)
                echo -e "${RED}Invalid choice! Please try again.${NC}\n"
                sleep 1
                ;;
        esac
    done
}

show_main_menu
