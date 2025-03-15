#!/bin/bash

# Bersihkan terminal sebelum program berjalan
clear

# Fungsi untuk Speak to Me (Menampilkan word of affirmation setiap detik)
speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | jq -r '.affirmation'
        sleep 1
    done
}

# Fungsi untuk On the Run (Progress bar dengan interval random)
on_the_run() {
    local width=$(tput cols)
    local bar_width=$((width - 10)) # Pastikan ada ruang untuk persentase di akhir
    local progress=0
    echo -e "LET'S GAUURRRR RUNNNN!!!"
    while [ $progress -lt 100 ]; do
        sleep $(awk -v min=0.1 -v max=1 'BEGIN{srand(); print min+rand()*(max-min)}')
        ((progress+=1))
        filled=$((progress * bar_width / 100))
        printf "\r[%-${bar_width}s] %3d%%" "$(head -c $filled < /dev/zero | tr '\0' '#')" "$progress"
    done
    echo ""
}

# Fungsi untuk Time (Menampilkan live clock)
time_display() {
    while true; do
        clear
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}

# Fungsi untuk Money (Menampilkan efek Matrix dengan simbol mata uang secara acak di seluruh layar)
money_display() {
    symbols=("$" "€" "£" "¥" "¢" "₹" "₩" "₿" "₣")
    cols=$(tput cols)
    lines=$(tput lines)
    while true; do
        clear
        for ((i=0; i<lines; i++)); do
            for ((j=0; j<cols; j++)); do
                if (( RANDOM % 5 == 0 )); then
                    printf "\033[32m%s" "${symbols[RANDOM % ${#symbols[@]}]}"
                else
                    printf " "
                fi
            done
            echo ""
        done
        sleep 0.1
    done
}

# Fungsi untuk Brain Damage (Menampilkan task manager sederhana dengan warna dan formatting)
brain_damage() {
    while true; do
        clear
        width=$(tput cols)
        echo -e "\033[1;36m==============================================\033[0m"
        echo -e "\033[1;36mB R A I N    D A M A G E\033[0m"
        echo -e "\033[1;36m==============================================\033[0m"
        echo -e "\033[1;36mUSER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND\033[0m"
        ps aux --sort=-%cpu | awk 'NR==1 || NR<=11' | while read line; do
            echo -e "\033[1;33m$line\033[0m"
        done
        sleep 1
    done
}

# Menjalankan fungsi berdasarkan input
case "$1" in
    --play="Speak to Me") speak_to_me ;;
    --play="On the Run") on_the_run ;;
    --play="Time") time_display ;;
    --play="Money") money_display ;;
    --play="Brain Damage") brain_damage ;;
    *) echo "Usage: ./dsotm.sh --play=\"<Track>\"" ;;
esac

