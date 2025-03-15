#!/bin/bash

CPU_MONITOR="./scripts/core_monitor.sh"
RAM_MONITOR="./scripts/frag_monitor.sh"

CYAN='\033[1;36m'
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'

show_header() {
    clear
    echo -e "${CYAN}┌───────────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}│ ${YELLOW}         🌌 ARCAEA MONITOR MANAGER 🌌         ${CYAN}│${RESET}"
    echo -e "${CYAN}└───────────────────────────────────────────────┘${RESET}"
}

loading_animation() {
    echo -n "Processing"
    for i in {1..3}; do
        echo -n "."
        sleep 0.5
    done
    echo ""
}

add_cron_job() {
    (crontab -l 2>/dev/null; echo "$1") | crontab -
    loading_animation
    echo -e "${GREEN}✅ Job telah ditambahkan ke crontab!${RESET}"
    sleep 1.5
}

remove_cron_job() {
    crontab -l | grep -v "$1" | crontab -
    loading_animation
    echo -e "${RED}❌ Job telah dihapus dari crontab!${RESET}"
    sleep 1.5
}

while true; do
    show_header
    echo -e "${CYAN}┌───────────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}│ ${YELLOW}1)${RESET} Add CPU - Core Monitor to Crontab          ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${YELLOW}2)${RESET} Add RAM - Fragment Monitor to Crontab      ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${YELLOW}3)${RESET} Remove CPU - Core Monitor from Crontab     ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${YELLOW}4)${RESET} Remove RAM - Fragment Monitor from Crontab ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${YELLOW}5)${RESET} View All Scheduled Monitoring Jobs         ${CYAN}│${RESET}"
    echo -e "${CYAN}│ ${YELLOW}6)${RESET} Exit Arcaea Terminal                       ${CYAN}│${RESET}"
    echo -e "${CYAN}└───────────────────────────────────────────────┘${RESET}"
    read -p "$(echo -e ${YELLOW}Enter option [1-6]: ${RESET})" choice

    case $choice in
        1)
            add_cron_job "*/5 * * * * $CPU_MONITOR"
            ;;
        2)
            add_cron_job "*/5 * * * * $RAM_MONITOR"
            ;;
        3)
            remove_cron_job "$CPU_MONITOR"
            ;;
        4)
            remove_cron_job "$RAM_MONITOR"
            ;;
        5)
            echo -e "${YELLOW}📜 Crontab saat ini:${RESET}"
            crontab -l
            echo -e "${CYAN}Tekan enter untuk kembali...${RESET}"
            read
            ;;
        6)
            echo -e "${GREEN}👋 Keluar dari Arcaea Terminal.${RESET}"
            exit 0
            ;;
        *)
            echo -e "${RED}⚠️ Pilihan tidak valid, coba lagi!${RESET}"
            sleep 1.5
            ;;
    esac
done
