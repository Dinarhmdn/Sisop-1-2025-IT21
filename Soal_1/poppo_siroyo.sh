#!/bin/bash

#wget "https://docs.google.com/uc?export=download&id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV" -O reading_data.csv
#awk -F',' '$2 ~ "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca " count " buku"}' reading_data.csv 
#awk -F',' '$8 ~ "Tablet" {sum+=$6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah " sum / count " menit"}' reading_data.csv 
#awk -F',' 'NR > 1 {if ($7 > max) {tittle = $3;max = $7; name = $2}} END {print "Pembaca dengan rating tertinggi: " name  "-"tittle "-" max}' reading_data.csv
#awk -F, '$9 == "Asia" && $5 > "2023-12-31" {genres[$4]++} END {max = 0; for (genre in genres) {if(genres[genre] > max) {max = genres[genre];most_common = genre;}} print "Genre paling populer di Asia setelah 2023 adalah " most_common " dengan " max " buku"}' reading_data.csv

while True; do
echo "Pilih opsi:"
echo "1. Hitung jumlah buku yang dibaca Chris Hemsworth"
echo "2. Hitung rata-rata durasi membaca dengan Tablet"
echo "3. Temukan pembaca dengan rating tertinggi"
echo "4. Cari genre paling populer di Asia setelah 2023"
echo "5. Exit"
read -p "Masukkan pilihan (1-4): " pilihan


if [[ "$pilihan" -eq 1 ]]; then
	awk -F',' '$2 ~ "Chris Hemsworth" {count++} END {print "Chris Hemsworth membaca " count " buku"}' reading_data.csv				
elif [[ "$pilihan" -eq 2 ]]; then
	awk -F',' '$8 ~ "Tablet" {sum+=$6; count++} END {if (count > 0) print "Rata-rata durasi membaca dengan Tablet adalah " sum / count " menit"}' reading_data.csv
elif [[ "$pilihan" -eq 3 ]]; then
	awk -F',' 'NR > 1 {if ($7 > max) {tittle = $3;max = $7; name = $2}} END {print "Pembaca dengan rating tertinggi: " name  "-"tittle "-" max}' reading_data.csv
elif [[ "$pilihan" -eq 4 ]]; then
	awk -F, '$9 == "Asia" && $5 > "2023-12-31" {genres[$4]++} END {max = 0; for (genre in genres) {if (genres[genre] > max) {max = genres[genre];most_common = genre;}} print "Genre paling populer di Asia setelah 2023 adalah " most_common " dengan " max " buku"}' reading_data.csv
elif [[ "$pilihan" -eq 5 ]]; then
	echo "Keluar dari program..."
	break
else
	echo "Pilihan tidak valid, silahkan coba lagi"
fi

done
