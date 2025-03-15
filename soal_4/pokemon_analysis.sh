#!/bin/bash

show_help() {
    cat << "EOF"
    ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣶⣿⣿⣿⣿⣿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀
    ⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡏⠀⠀⠙⣿⣿⣿⣿⣿⣆⠀⠀
    ⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠿⢿⣧⡀⠀⢠⣿⠟⠛⠛⠿⣿⡆⠀
    ⠀⢰⣿⣿⣿⣿⣿⣿⠿⠟⠋⠉⠁⠀⠀⠀⠀⠀⠙⠿⠿⠟⠋⠀⠀⠀⣠⣿⠇⠀
    ⠀⢸⣿⣿⡿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⠟⠋⠀⠀
    ⠀⢸⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣴⣾⠿⠛⠉⠀⠀⠀⠀⠀
    ⠀⠈⢿⣷⣤⣤⣄⣠⣤⣤⣤⣤⣶⣶⣾⠿⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⢠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀
    ⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀
    ⠀⢸⣿⡛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀
    ⠀⠀⢻⣧⠀⠈⠙⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
    ⠀⠀⠈⢿⣧⠀⠀⠀⠀⠀⠀⠉⠙⠛⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀
    ⠀⠀⠀⠀⠻⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⠟⠀⣠⣾⠟⠀⠀⠀
    ⠀⠀⠀⠀⠀⠈⠻⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⢀⣤⣾⠟⠁⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⣶⣦⣤⣤⣤⣤⣤⣤⣶⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                            
EOF
    echo "---------------------------------------------------------"
    echo "Usage: $0 <file.csv> <command> [options]"
    echo "---------------------------------------------------------"
    echo "Commands:"
    echo "  -h, --help              : Show this help screen"
    echo "  -i, --info              : Display data summary"
    echo "  -s, --sort <col>        : Sort by the following columns:"
    echo "      name                : Name (Alphabetical Order)"
    echo "      usage               : Adjusted Usage (Descending)"
    echo "      raw                 : Raw Usage (Descending)"
    echo "      hp, atk, def        : Pokemon Stats (Descending)"
    echo "      spatk, spdef, speed : Other stats (Descending)"
    echo "  -g, --grep <name>       : Search Pokemon by name"
    echo "  -f, --filter <type>     : Filter Pokemon by type"
    echo "---------------------------------------------------------"
    echo "Example Usage:"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort usage"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep Pikachu"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter Fire"
    echo "---------------------------------------------------------"
    exit 0
}

# memanggil help screen
test "$1" == "-h" || test "$1" == "--help" && show_help

# argumen input
if [[ $# -lt 2 ]]; then
    echo "Error: Missing arguments! Use --help for command list."
    exit 1
fi

CSV_FILE="$1"
COMMAND="$2"

if [[ ! -f "$CSV_FILE" ]]; then
    echo "Error: File $CSV_FILE not found!"
    exit 1
fi

case "$COMMAND" in
    --info)
        echo "Displaying data summary..."
        
        # cari Usage% tertinggi pokemon
        top_usage=$(awk -F',' 'NR>1 {if($2>max) {max=$2; name=$1}} END {print name "," max}' "$CSV_FILE")
        
        # cari RawUsage tertinggi pokemon
        top_raw=$(awk -F',' 'NR>1 {if($3>max) {max=$3; name=$1}} END {print name "," max}' "$CSV_FILE")
        
        echo "Summary of $CSV_FILE"
        echo "Top Adjusted Usage: $(echo $top_usage | cut -d',' -f1) with $(echo $top_usage | cut -d',' -f2)%"
        echo "Top Raw Usage: $(echo $top_raw | cut -d',' -f1) with $(echo $top_raw | cut -d',' -f2) uses"
        ;;

    --sort)
        [[ -z "$3" ]] && { echo "Error: No sorting column provided"; exit 1; }

        SORT_COL="$3"
        case "$SORT_COL" in
            usage) COL_NUM=2 ;;  
            raw) COL_NUM=3 ;;    
            hp) COL_NUM=4 ;;     
            atk) COL_NUM=5 ;;    
            def) COL_NUM=6 ;;    
            spatk) COL_NUM=7 ;;  
            spdef) COL_NUM=8 ;;  
            speed) COL_NUM=9 ;;  
            name) COL_NUM=1 ;;   
            *) 
                echo "Error: Invalid column! Choose from: usage, raw, name, hp, atk, def, spatk, spdef, speed"
                exit 1
                ;;
        esac

        echo "Sorting by $SORT_COL..."

        if [[ "$SORT_COL" == "name" ]]; then
            awk 'NR==1; NR>1 {print $0 | "sort -t, -k1,1"}' "$CSV_FILE"
        else
            awk 'NR==1; NR>1 {print $0 | "sort -t, -k'"$COL_NUM"','"$COL_NUM"'nr"}' "$CSV_FILE"
        fi
        ;;

    --grep)
        [[ -z "$3" ]] && { echo "Error: No search term provided"; exit 1; }

        SEARCH_NAME="$3"
        echo "Searching for Pokemon named: $SEARCH_NAME..."

        # cari nama pokemon 
        result=$(awk -F',' 'BEGIN {IGNORECASE=1} $1 ~ /'"$SEARCH_NAME"'/ {print}' "$CSV_FILE")

        [[ -n "$result" ]] && echo "$result" || echo "Pokemon \"$SEARCH_NAME\" not found."
        ;;

    --filter)
        [[ -z "$3" ]] && { echo "Error: No filter option provided"; exit 1; }

        POKEMON_TYPE="$3"
        echo "Filtering Pokemon with type: $POKEMON_TYPE..."

        # cari tipe pokemon
        result=$(awk -F',' 'BEGIN {IGNORECASE=1} $4 ~ /'"$POKEMON_TYPE"'/ || $5 ~ /'"$POKEMON_TYPE"'/ {print}' "$CSV_FILE")

        [[ -n "$result" ]] && echo "$result" || echo "No Pokemon found with type \"$POKEMON_TYPE\"."
        ;;

    *)
        echo "Error: Unknown command! Use --help for command list."
        exit 1
        ;;
esac
