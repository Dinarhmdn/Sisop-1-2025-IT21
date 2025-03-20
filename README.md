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
memastikan argumen yang diinput menyesuaikan parameter, yaitu <email> <username> <password>

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
membuat parameter untuk login, yaitu <email> <password>

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
  
