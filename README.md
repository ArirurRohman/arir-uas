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
# C. Modul Dasbor Keuangan & Pengingat
    - Kalkulator Total Biaya: Menghitung otomatis total uang yang sudah dihabiskan untuk satu kendaraan tertentu.
    - Estimasi Servis Berikutnya: Logika sederhana yang mengingatkan pengguna untuk servis kembali 6 bulan setelah tanggal servis terakhir.
