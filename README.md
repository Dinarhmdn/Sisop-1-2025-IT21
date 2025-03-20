# Laporan Praktikum IT21
Soal_1
1. Pendahuluan
Script Bash ini dibuat untuk menganalisis data membaca yang tersimpan dalam file CSV bernama reading_data.csv. Analisis dilakukan menggunakan perintah awk untuk menyaring dan menghitung informasi tertentu dari dataset.

2. Tujuan
Tujuan dari script ini adalah untuk:

Menentukan jumlah buku yang dibaca oleh Chris Hemsworth.

Menghitung rata-rata durasi membaca dengan perangkat Tablet.

Menemukan pembaca dengan rating tertinggi.

Mengidentifikasi genre paling populer di Asia setelah tahun 2023.

3. Metode
Script menggunakan perintah awk untuk memproses data CSV dan menghasilkan informasi yang diinginkan. Pengguna diberikan pilihan dalam menu untuk menjalankan salah satu dari empat analisis atau keluar dari program.

4. Implementasi
Script berjalan dalam loop while dan menyediakan opsi kepada pengguna untuk memilih analisis yang ingin dijalankan:

Menghitung jumlah buku yang dibaca oleh Chris Hemsworth

Menggunakan awk untuk menghitung jumlah entri di mana kolom kedua berisi "Chris Hemsworth".

Menghitung rata-rata durasi membaca dengan Tablet

Menjumlahkan nilai durasi membaca di kolom keenam untuk entri yang memiliki "Tablet" di kolom kedelapan.

Menghitung rata-rata dengan membagi total durasi dengan jumlah entri.

Menemukan pembaca dengan rating tertinggi

Menggunakan awk untuk mencari nilai rating tertinggi di kolom ketujuh.

Menampilkan nama pembaca dan judul buku yang memiliki rating tertinggi.

Menentukan genre paling populer di Asia setelah tahun 2023

Menggunakan awk untuk menghitung jumlah buku berdasarkan genre untuk entri dengan lokasi "Asia" (kolom ke-9) dan tanggal setelah 2023-12-31 (kolom ke-5).

Menampilkan genre dengan jumlah terbanyak.

5. Hasil dan Analisis

Jika Chris Hemsworth telah membaca buku, hasilnya akan menampilkan jumlahnya.

Jika ada pengguna yang membaca dengan Tablet, rata-rata durasi akan ditampilkan.

Pembaca dengan rating tertinggi akan ditampilkan beserta judul bukunya.

Genre paling populer di Asia setelah tahun 2023 akan disebutkan dengan jumlah bukunya.

6. Kesimpulan
Script ini memungkinkan analisis cepat terhadap data membaca menggunakan awk. Dengan menu interaktif, pengguna dapat dengan mudah memilih jenis analisis yang diinginkan. Program ini dapat dikembangkan lebih lanjut dengan fitur tambahan seperti validasi input lebih ketat atau ekspor hasil ke file eksternal.

7. Saran Pengembangan

Menambahkan fitur ekspor hasil ke file.

Meningkatkan tampilan output agar lebih rapi.

Memvalidasi input pengguna agar menghindari kesalahan saat memilih opsi.

Demikian laporan ini dibuat sebagai dokumentasi penggunaan script Bash untuk analisis data membaca.


