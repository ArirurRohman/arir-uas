## 1. Spesifikasi Fungsional (Fitur Aplikasi)
Aplikasi ini dibagi menjadi 3 modul utama yang saling terintegrasi:
* A. Modul Manajemen Garasi (Garasi Saya)
    - Tambah/Edit Kendaraan: Pengguna dapat memasukkan data mobil baru (Nama, Merek, Tahun, dan Foto).
    - Kamera & Galeri Integrasi: Pengguna bisa mengambil foto mobil langsung dari kamera HP atau memilih dari galeri untuk dijadikan profil kendaraan.
    - Hapus Kendaraan: Menghapus kendaraan beserta seluruh riwayat servis yang terikat dengannya (Cascade Delete).
* B. Modul Catatan Servis (Log Servis)
1. Input Riwayat Servis: Mencatat tindakan perawatan yang meliputi:
    - Jenis Servis (misal: Ganti Oli, Ganti Ban, Tune Up).
    - Tanggal Pelaksanaan.
    - Biaya Servis (dalam Rupiah).
    - Catatan Tambahan (misal: "Menggunakan oli Shell Helix 5W-40").
2. Riwayat Terfilter: Menampilkan daftar servis khusus untuk mobil yang sedang dipilih oleh pengguna.
## C. Modul Dasbor Keuangan & Pengingat
    - Kalkulator Total Biaya: Menghitung otomatis total uang yang sudah dihabiskan untuk satu kendaraan tertentu.
    - Estimasi Servis Berikutnya: Logika sederhana yang mengingatkan pengguna untuk servis kembali 6 bulan setelah tanggal servis terakhir.
2. Spesifikasi Teknis (Tech Stack)
- Komponen:Framework, Database Lokal, State Management, Penyimpanan Gambar.
- Teknologi : Flutter (Dart) v3.x, Hive, Provider, Path Provider.
- Alasan Pemilihan: Pengembangan lintas platform (Android/iOS) dengan performa native, Database NoSQL lokal yang sangat cepat, ringan, dan tidak membutuhkan penulisan sintaks SQL yang panjang untuk operasi CRUD sederhana, Standar bawaan dari Google yang mudah dipahami untuk mengatur alur data antara UI dan Database, Menyimpan file foto yang diambil kamera ke dalam direktori lokal storage aplikasi agar aman. 
3. Spesifikasi Antarmuka (UI/UX)
    - Tema Desain: Modern Dark Mode. Dominasi warna hitam/abu-abu gelap (#121212) dengan aksen warna tegas seperti Neon Red atau Sporty Orange untuk memberikan kesan otomotif yang kuat.

Layout Utama:
- Beranda: Menggunakan Aesthetic Card horizontal yang bisa  digeser (carousel) untuk memilih mobil.

- Detail: Menggunakan teknik SliverAppBar agar foto mobil (misal: Nissan GTR atau Innova Venturer) bisa mengecil secara elegan saat layar di-scroll ke bawah.
4. Kebutuhan Library (Dependencies)
Kamu perlu menambahkan beberapa package berikut di file pubspec.yaml milikmu:
dependencies:
  flutter:
    sdk: flutter
  hive_flutter: ^1.1.0      # Database lokal
  provider: ^6.1.2          # State management
  image_picker: ^1.0.7      # Akses kamera dan galeri
  intl: ^0.19.0             # Untuk format tanggal & mata uang Rupiah
  google_fonts: ^6.1.0      # Font custom (misal: Montserrat)
  5. Logika Data & Aturan Bisnis (Business Rules)
- Relasi Data: Setiap ServiceLog wajib memiliki carId. Jika data mobil dihapus, maka data ServiceLog yang memiliki carId tersebut juga harus ikut terhapus dari database agar tidak membebani memori.
- Validasi Form: Input biaya tidak boleh menerima huruf (harus angka/TextInputType.number) dan form nama kendaraan tidak boleh kosong.
- Format Mata uang: Semua angka biaya yang diinput (misal: 1500000) harus otomatis ditampilkan di UI menjadi Rp 1.500.000.