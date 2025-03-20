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


# Soal_2
