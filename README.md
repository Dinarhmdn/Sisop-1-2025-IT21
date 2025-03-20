# Laporan Praktikum Sisop Modul 1 Kelompok IT21
# Anggota
1. Nisrina Bilqis - 5027241054
2. Hanif Mawla Faizi - 5027241064
3. Dina Rahmadani - 5027241065

# Soal_1
1.  Mengunduh Dataset
```sh
wget "https://docs.google.com/uc?export=download&id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV" -O reading_data.csv
```
```wget``` digunakan untuk mengunduh file CSV dari Google Drive dan menyimpannya sebagai ```reading_data.csv.```

2. Menghitung jumlah buku yang dibaca oleh Chris Hemsworth
```sh
awk -F',' '$2 ~ "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca " count " buku"}' reading_data.csv
```
```-F',' ```menentukan pemisah kolom sebagai koma (CSV).
```$2 ~ "Chris Hemsworth"``` mencari baris dengan nama "Chris Hemsworth" di kolom kedua.
```count++``` menghitung jumlah baris yang sesuai.
```END {print ...}``` menampilkan hasil.

3. Menghitung rata-rata durasi membaca dengan Tablet
```sh
awk -F',' '$8 ~ "Tablet" {sum+=$6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah " sum / count " menit"}' reading_data.csv
```
```$8 ~ "Tablet"``` mencari baris dengan "Tablet" di kolom kedelapan.
```sum+=$6``` menambahkan durasi membaca dari kolom keenam.
```count++``` menghitung jumlah baris yang sesuai.
```END``` menghitung rata-rata (```sum / count```) dan menampilkan hasil.

4. Menemukan pembaca dengan rating tertinggi
```sh
awk -F',' 'NR > 1 {if ($7 > max) {tittle = $3;max = $7; name = $2}} END {print "Pembaca dengan rating tertinggi: " name  "-" tittle "-" max}' reading_data.csv
```
```NR > 1``` melewati baris pertama (header).
```$7 > max``` mencari rating tertinggi di kolom ketujuh.
```tittle = $3, name = $2``` menyimpan judul buku dan nama pembaca.
```END {print ...}``` menampilkan hasil.

5. Mencari genre paling populer di Asia setelah 2023
```sh
   awk -F, '$9 == "Asia" && $5 > "2023-12-31" {genres[$4]++} END {max = 0; for (genre in genres) {if (genres[genre] > max) {max = genres[genre];most_common = genre;}} print "Genre paling populer di Asia setelah 2023 adalah " most_common " dengan " max " buku"}' reading_data.csv
```
```$9 == "Asia"``` memfilter lokasi "Asia" di kolom kesembilan.
```$5 > "2023-12-31"``` hanya mengambil data setelah 31 Desember 2023.
```genres[$4]++``` menghitung jumlah buku untuk setiap genre.
```for (genre in genres) { ... } ```mencari genre dengan jumlah tertinggi.
```END {print ...}``` menampilkan hasil.

6. Menjalankan Script Bash
```sh
chmod +x script.sh
./script.sh
```
```chmod +x script.sh``` memberikan izin eksekusi pada script.

```./script.sh``` menjalankan script.

# REVISI 

# Deskripsi Perubahan
Pada revisi ini, program telah diperbarui untuk mendukung klik opsi manual dalam pemilihan menu. Sebelumnya, pengguna harus memasukkan angka secara manual untuk memilih opsi. Kini, dengan tambahan fitur interaktif, pengguna bisa memilih opsi menggunakan tombol yang lebih mudah dipilih.

# Perubahan yang Dilakukan

1. Menambahkan Looping pada Menu

Program akan terus berjalan hingga pengguna memilih opsi "Exit".

Pengguna dapat memilih opsi berulang kali tanpa harus menjalankan kembali skrip.

2. Meningkatkan Interaksi dengan Pilihan Manual

Menggunakan ```select``` untuk menampilkan pilihan sebagai daftar yang lebih interaktif.

Menghindari input manual yang rentan kesalahan dengan format yang lebih terstruktur.
contoh output :
![WhatsApp Image 2025-03-20 at 19 49 43_9e26709b](https://github.com/user-attachments/assets/cd3b83a2-d390-4031-b0e9-3428f5c4c6d4)




# Soal_2
Anda merupakan seorang “Observer”, dari banyak dunia yang dibuat dari ingatan yang berbentuk “fragments” - yang berisi kemungkinan yang dapat terjadi di dunia lain. Namun, akhir-akhir ini terdapat anomali-anomali yang seharusnya tidak terjadi, perpindahan “fragments” di berbagai dunia, yang kemungkinan terjadi dikarenakan seorang “Seeker” yang berubah menjadi “Ascendant”, atau dalam kata lain, “God”. Tidak semua “Observer” menjadi “Player”, tetapi disini anda ditugaskan untuk ikut serta dalam menjaga equilibrium dari dunia-dunia yang terbuat dari “Arcaea”. 
[Author: Nathan / etern1ty]

# Analisis soal
Soal ini meminta kita untuk membuat sistem dengan ketentuan berikut :

1. Autentikasi pengguna (register/login) dengan validasi input dan hashing password.
2. Pemantauan sumber daya sistem (CPU dan RAM).
3. Pembuatan sistem logging dan otomatisasi dengan cron job.
4. Antarmuka shell script yang mengintegrasikan semua fitur di dalamnya.

# Tahap Pertama, Membuat Kerangka
# 1. Persiapan
```sh
touch register.sh && touch login.sh && mkdir data
```
membuat file ``register.sh`` dan ``login.sh`` dan memberi izin execute

# 2. script ``register.sh``
```sh
USER_DB="data/player.csv"
SALT_KEY="garem"
```
menentukan lokasi database dan membuat salt key dengan string bebas untuk hashing, disini kita menggunakan string "garem"


```sh
if [[ ! -f "$USER_DB" ]]; then
    echo -e "${YELLOW}User database not found. Creating database...${NC}"
    mkdir -p "$(dirname "$USER_DB")" && touch "$USER_DB"
    echo "email,username,password_hash" > "$USER_DB"
    echo -e "${GREEN}Database created successfully.${NC}"
fi
```
membuat database jika database setelah user melakukan regist. Database akan dibuat otomatis setelah register jika sebelumnya database tidak ditemukan


```sh
validate_email() {
    local email="$1"
    if [[ "$email" == *"@"* && "$email" == *"."* ]]; then
        return 0
    else
        return 1
    fi
}
```
fungsi untuk memvalidasi email, memastikan bahwa format email yang diinput adalah mengandung karakter "@" dan "."


```sh
validate_password() {
    local password="$1"
    if [[ ${#password} -lt 8 || ! "$password" =~ [A-Z] || ! "$password" =~ [a-z] || ! "$password" =~ [0-9] ]]; then
        return 1
    else
        return 0
    fi
}
```
fungsi untuk memvalidasi password, memastikan bahwa format password yang diinput ada : setidaknya 1 huruf kapital, 8 karakter panjangnya, dan ada setidaknya 1 angka


```sh
# cek argumen register
if [[ $# -ne 3 ]]; then
    echo -e "${YELLOW}Usage: register.sh <email> <username> <password>${NC}"
    exit 1
fi

user_email="$1"
user_username="$2"
user_password="$3"
```
memastikan argumen yang diinput menyesuaikan parameter, yaitu email username password

```sh
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
```
mengeluarkan error apabila email dan password tidak sesuai syarat dan juga mengeluarkan error jika email sudah terdaftar


```sh
# Hashing password
hashed_password=$(echo -n "$SALT_KEY$user_password" | sha256sum | awk '{print $1}')

# simpan data ke database
echo "$user_email,$user_username,$hashed_password" >> "$USER_DB"
echo -e "${GREEN}Registration successful! Welcome, $user_username 🎉${NC}"
```
hashing password dengan algoritma ``sha256sum`` dan masukan email, username, dan password yang telah dihash ke database


# 3. script ``login.sh``
```sh
DB_FILE="data/player.csv"
SALT="garem"
```
menentukan lokasi database yang telah dibuat dan salt key yang sama dengan register

```sh
if [[ ! -f "$DB_FILE" ]]; then
    echo -e "${RED}Error: Database not found!${NC}"
    exit 1
fi
```
mengeluarkan error jika database tidak ditemukan, akan terjadi jika belum pernah register sebelumnya

```sh
# parameter login
if [[ $# -ne 2 ]]; then
    echo -e "${YELLOW}Usage: login.sh <email> <password>${NC}"
    exit 1
fi

email="$1"
password="$2"
```
membuat parameter untuk login, yaitu email password

```sh
# hash password
hashed_input=$(echo -n "$SALT$password" | sha256sum | awk '{print $1}')
```
hash password yang telah diinput dengan salt key dan hash algoritma ``sha256sum`` yang nantinya akan dibandingkan di database

```sh
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
```
mencari email di database dan jika ketemu, password yang diinput akan dibandingkan dengan password yang ada di register

# Tahap Kedua, Lanjutan
# 4. membuat file ``core_monitor.sh`` , ``frag_monitor.sh`` pada direktori ``scripts/``
``core_monitor.sh`` digunakan untuk melacak penggunaan CPU (dalam persentase).
``frag_monitor.sh`` digunakan untuk memantau persentase usage, dan juga penggunaan RAM sekarang. 

- Script ``core_monitor.sh``
```sh
LOG_FILE="../logs/core.log"
```
menentukan lokasi file ``core.log`` yang dimana digunakan untuk menaruh output dari script ``core_monitor.sh

```sh
while true; do
    # jumlah core CPU yang aktif
    num_cores=$(nproc)

    # persentase CPU usage
    cpu_usage=$(top -bn1 | awk '/Cpu\(s\):/ {print $2 + $4}')

    # model CPU
    cpu_model=$(lscpu | grep "Model name" | sed -E 's/Model name:\s+//')

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    # simpan hasil monitoring
    echo "[$timestamp] -- Core Usage [${cpu_usage}%] -- Terminal Model [$cpu_model]" >> "$LOG_FILE"

    # tampilkan hasil ke terminal
    echo "[$timestamp] -- Core Usage: ${cpu_usage}%, CPU Model: $cpu_model"

    sleep 5
done
```
script ini akan melakukan infinite loop hingga user meng-cancel eksekusi dari script ini, dan script ini akan mengeluarkan output tentang CPU Usage selama 5 detik sekali, dengan format ``[YYYY-MM-DD HH:MM:SS] - Core Usage [$CPU%] - Terminal Model [$CPU_Model]``

- Script ``frag_monitor.sh``
```sh
FRAG_LOG="../logs/fragment.log"
```
mencari lokasi ``frag.log`` untuk menaruh output dari script ``frag_monitor.sh``

```sh
# ambil informasi RAM dari sistem secara langsung
ram_total=$(free -m | awk '/Mem:/ {print $2}') 
ram_used=$(free -m | awk '/Mem:/ {print $3}')
ram_usage=$(perl -E "say sprintf('%.2f', ($ram_used/$ram_total)*100)")
```
mengambil informasi total ram yang tersedia (dalam MB), ram yang terpakai (dalam MB), serta persentase ram yang digunakan

```sh
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
```
untuk memenuhi keinginan output yaitu : ``[YYYY-MM-DD HH:MM:SS] - Fragment Usage [$RAM%] - Fragment Count [$RAM MB] - Details [Total: $TOTAL MB, Available: $AVAILABLE MB]``

```sh
# save hasil ke fragment.log
echo "[$timestamp] -- Fragment Usage [${ram_usage}%] -- Fragment Count [$(perl -E "say sprintf('%.2f', $ram_used)") MB] -- Details [Total: ${ram_total} MB, Available: $(($ram_total - $ram_used)) MB]" >> "$FRAG_LOG"

# show
echo "[$timestamp] -- Fragment Usage [${ram_usage}%] -- Fragment Count [$(perl -E "say sprintf('%.2f', $ram_used)") MB] -- Details [Total: ${ram_total} MB, Available: $(($ram_total - $ram_used)) MB]"
```
menyimpan output dari script ``frag_monitor.sh`` dan menampilkannya di terminal

# 5. membuat crontab manager pada ``manager.sh``
```sh
CPU_MONITOR="./scripts/core_monitor.sh"
RAM_MONITOR="./scripts/frag_monitor.sh"
```
untuk mencari script ``core_monitor`` dan ``frag_monitor``

```sh
add_cron_job() {
    (crontab -l 2>/dev/null; echo "$1") | crontab -
    loading_animation
    echo -e "${GREEN}✅ Job telah ditambahkan ke crontab!${RESET}"
    sleep 1.5
}
```
untuk menambahkan cronjob ke crontab

```sh
remove_cron_job() {
    crontab -l | grep -v "$1" | crontab -
    loading_animation
    echo -e "${RED}❌ Job telah dihapus dari crontab!${RESET}"
    sleep 1.5
}
```
menghapus cronjob pada crontab

```sh
while true; do
    echo -e "${CYAN}│ ${YELLOW}1)${RESET} Add CPU - Core Monitor to Crontab
    echo -e "${CYAN}│ ${YELLOW}2)${RESET} Add RAM - Fragment Monitor to Crontab     
    echo -e "${CYAN}│ ${YELLOW}3)${RESET} Remove CPU - Core Monitor from Crontab    
    echo -e "${CYAN}│ ${YELLOW}4)${RESET} Remove RAM - Fragment Monitor from Crontab
    echo -e "${CYAN}│ ${YELLOW}5)${RESET} View All Scheduled Monitoring Jobs        
    echo -e "${CYAN}│ ${YELLOW}6)${RESET} Exit Arcaea Terminal                    
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
```
menampilkan menu crontab manager yang bisa melakukan :
1. menambahkan core monitor ke crontab
2. menambahkan fragment monitor ke crontab
3. menghapus core monitor dari crontab
4. menghapus fragment monitor dari crontab
5. melihat semua jadwal monitoring pada crontab
6. keluar dari program

# 6. membuat direktori ``logs`` yang setara dengan direktori ``scripts/``, dan membuat file ``core.log`` dan ``fragment.log``
```sh
mkdir logs && cd logs && touch core.log && touch fragment.log
```
file ``core.log`` dan ``fragment.log`` dalam direktori ``logs``berfungsi untuk menyimpan output dari core monitor dan ram monitor

# Tahap Ketiga, Finishing
# 7. membuat antarmuka utama sebagai titik masuk sistem dalam ``terminal.sh``
```sh
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

```
menampilkan main menu dan meminta input user

```sh
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
```
-pada pilihan 1, user akan registrasi dan diminta untuk mengisi email username dan password, lalu memanggil script ``register.sh`` untuk mengeksekusi input nya.
-pada pilihan 2, user akan login dan diminta untuk mengisi email dan password, lalu memanggil script ``login.sh`` untuk mengeksekusi input nya.
-pada pilihan 3, user akan keluar dari ``terminal.sh``.
output ``terminal.sh``
![Screenshot 2025-03-20 213126](https://github.com/user-attachments/assets/b4090e42-b4fd-4553-af03-a7032d1ae907)


```sh
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
```
saat user telah berhasil login, user akan dialihkan ke menu ini, dimana user bisa mengakses ``crontab manager`` yang telah dibuat pada sebelumnya.
jika telah berhasil login, maka user dapat mengakses crontab manager :
![Screenshot 2025-03-20 213152](https://github.com/user-attachments/assets/5a0d09e3-78df-4881-87e5-f82cde9a421b)

# Soal 3
Untuk merayakan ulang tahun ke 52 album The Dark Side of the Moon, tim PR Pink Floyd mengadakan sebuah lomba dimana peserta diminta untuk membuat sebuah script bertemakan setidaknya 5 dari 10 lagu dalam album tersebut. Sebagai salah satu peserta, kamu memutuskan untuk memilih Speak to Me, On the Run, Time, Money, dan Brain Damage. Saat program ini dijalankan, terminal harus dibersihkan terlebih dahulu agar tidak mengganggu tampilan dari fungsi-fungsi yang kamu buat.
Program ini dijalankan dengan cara ./dsotm.sh --play=”<Track>” dengan Track sebagai nama nama lagu yang kamu pilih. [Author: Afnaan / honque]

# Analisis Soal
Sesuai perintah dari kebutuhan soal, skrip untuk soal ini menggunakan beberapa perintah sistem seperti curl, jq, figlet, toilet, dan ps untuk menampilkan informasi dan efek visual yang menarik di terminal.
## Pembersihan Layar Awal
Pada soal dijelaskan untuk membersihkan layar terminal terlebih dahulu, perintah ini dijalankan dengan :
```sh
clear
```
Dengan begini terminal telah dibersihkan dan memberikan tampilan yang rapi. Seperti tampilan di bawah ini :
![image](https://github.com/user-attachments/assets/6b3d0fa3-ea21-4772-8c91-26d1e519000d)

## Speak to Me
Pada soal ini, ini diminta untuk menampilkan afirmasi positif dari API eksternal (https://www.affirmations.dev) setiap detik. Maka di sini kami menggunakan curl dan memprosesnya dengan jq untuk menmapilkan API tersebut.
```sh
on_the_run() {
    local width=$(tput cols)
    local bar_width=$((width - 10))
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
```
Dengan ini afirmasi positif dari API eksternal dapat ditampilkan setiap detiknya sesuai pada output di bawah ini :
![image](https://github.com/user-attachments/assets/fd706978-e466-4bfe-9fad-835892ce0c9a)
## On the Run
Pada soal ini kita diminta untuk menampilkan progress bar dengan peningkatan acak hingga mencapai 100%.
```sh
on_the_run() {
    local width=$(tput cols)
    local bar_width=$((width - 10))
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
```
Menggunakan kode di atas, progress bar dapat ditampilkan tiap detik seperti pada gambar di bawah ini :
![image](https://github.com/user-attachments/assets/d7ac4179-36f0-427c-a769-6d0f9d6f8dbf)
## Time
Soal ini diperintahkan untuk menampilkan waktu secara real-time yang berubah pada setiap detiknya.
```sh
time_display() {
    while true; do
        clear
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}
```
Dengan perintah menambahkan tanggal dan waktu secara detail seperti di atas, didapatkan output seperti ini :
![image](https://github.com/user-attachments/assets/b1408a7f-89d1-4b97-a8ad-754199a7b468)
## MOney
Pada soal ini, kita perlu menampilkan hujan uang.
```sh
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
```
Dengan perintah yang me-looping simbol mata uang pada tiap cols dan line, maka simbol mata uang akan muncul secara acak pada terminal yang akan menciptakan efek hujan uang. Output :
![image](https://github.com/user-attachments/assets/5a40eecd-a0a2-4d8d-bee5-674f1ff7118f)
## Brain Damage
Soal ini menampilkan task manager yang sedang aktif bekerja secara sederhana dan menampilkan daftar proses dengan penggunaan CPU tertinggi.
```sh
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
```
Menggunakan ps aux tersebut kita dapat mengetahui apa yang sedang terproses dalam task manager kita dan menampilkannya di terminal dengan pembaruan tiap detiknya. Seperti pada output di bawah ini :
![image](https://github.com/user-attachments/assets/e7d28b80-61cf-4c57-bc4a-3616784303e4)
## Pemrosesan Argumen Output
```sh
case "$1" in
    --play="Speak to Me") speak_to_me ;;
    --play="On the Run") on_the_run ;;
    --play="Time") time_display ;;
    --play="Money") money_display ;;
    --play="Brain Damage") brain_damage ;;
    *) echo "Usage: ./dsotm.sh --play=\"<Track>\"" ;;
esac
```
Skrip ini membaca argumen input untuk mengeksekusi fungsi yang sesuai dengan perintah --play="<Track>". Sehingga, fungsi-fungsi di atas dapat berjalan dengan baik sesuai input yang diminta.

# Soal 4
Pada suatu hari, anda diminta teman anda untuk membantunya mempersiapkan diri untuk turnamen Pokemon “Generation 9 OverUsed 6v6 Singles” dengan cara membuatkan tim yang cocok untuknya. Tetapi, anda tidak memahami meta yang dimainkan di turnamen tersebut. Untungnya, seorang informan memberikan anda data pokemon_usage.csv yang bisa anda download dan analisis. 
[Author: Amoes / winter]
# Analisis soal 
soal ini meminta kita untuk menganalisis data dari file ``pokemon_usage.csv``. Analisis dilakukan menggunakan script ``pokemon_analysis.sh`` dengan beberapa fitur utama yang harus dibuat sebagai berikut :
1. help screen
2. menampilkan summary data pokemon (info)
3. mengurutkan pokemon berdasarkan kolom tertentu (sort)
4. mencari pokemon berdasarkan nama (grep)
5. mencari pokemon berdasarkan tipe (filter)
6. error handling

# 1. membuaat help screen yang menarik
```sh
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
```
fungsi untuk menampilkan help screen yang bisa membantu user untuk menggunakan sistem pokemon anaysis ini

```sh
# memanggil help screen
test "$1" == "-h" || test "$1" == "--help" && show_help
```
jika user menginput command ``-h`` atau ``--help`` maka akan memanggil help screen di atas. seperti berikut :
![Screenshot 2025-03-20 213820](https://github.com/user-attachments/assets/9ba57e6a-d559-4282-b484-0ff42bba5f26)

```sh
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
```
untuk membuat parameter input untuk menjalankan sistem analysis pokemon, jika file csv tidak ditemukan, mengeluarkan error

```sh
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
```
membuat fungsi ``--info`` untuk menampilkan usage% tertinggi dan RawUsage tertinggi pokemon, seperti berikut :
![image](https://github.com/user-attachments/assets/a726cf42-bad7-4a6f-a367-0aae8df2d7bc)

```sh
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
```
membuat fungsi ``--sort`` untuk mengurutkan pokemon berdasarkan kolom, contoh :
![image](https://github.com/user-attachments/assets/26f0d3ab-8af6-47d9-af05-c698dca3194c)

```sh
    --grep)
        [[ -z "$3" ]] && { echo "Error: No search term provided"; exit 1; }

        SEARCH_NAME="$3"
        echo "Searching for Pokemon named: $SEARCH_NAME..."

        # cari nama pokemon 
        result=$(awk -F',' 'BEGIN {IGNORECASE=1} $1 ~ /'"$SEARCH_NAME"'/ {print}' "$CSV_FILE")

        [[ -n "$result" ]] && echo "$result" || echo "Pokemon \"$SEARCH_NAME\" not found."
        ;;
```
membuat fungsi grep untuk mencari pokemon berdasarkan nama, contoh :
![image](https://github.com/user-attachments/assets/c11d96a8-dd02-4081-942c-4a47eda0e8c4)

```sh
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
```
membuat fungsi ``--filter`` untuk mencari pokemon berdasarkan type, contoh :
![image](https://github.com/user-attachments/assets/e1e87f41-b235-4209-b798-9cb595a8e4c8)






