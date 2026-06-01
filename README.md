# OtoPro Workshop - Sistem Kasir Bengkel

OtoPro Workshop KASIR adalah aplikasi Point of Sale (POS) berbasis Flutter Web yang dirancang khusus untuk memenuhi kebutuhan transaksi di bengkel otomotif. Aplikasi ini memiliki antarmuka (UI) yang modern, bersih, dan fungsional, memungkinkan kasir untuk dengan cepat memproses pesanan layanan jasa maupun suku cadang.

## Fitur Utama

- **Antarmuka Responsif (Responsive UI)**: Aplikasi secara otomatis menyesuaikan tampilan baik ketika dibuka di layar desktop, tablet, maupun layar handphone (mobile). Layout akan menyesuaikan diri menjadi satu kolom memanjang pada layar kecil agar tetap nyaman digunakan.
- **Manajemen Data Pelanggan**: Pencatatan mudah untuk Nomor Polisi kendaraan, Nama Pelanggan, Nomor WhatsApp, dan Merk/Tipe Mobil pada setiap transaksi.
- **Daftar Layanan & Suku Cadang**: 
  - Tampilan grid/list interaktif untuk menambah item ke keranjang.
  - Dilengkapi dengan fitur **Pencarian (Search Bar)** untuk mempercepat pencarian item tertentu.
- **Keranjang Pesanan Dinamis**: 
  - Penambahan kuantitas (QTY) otomatis jika item yang sama ditekan beberapa kali.
  - Opsi penghapusan item dari keranjang dengan mudah.
- **Kalkulasi Otomatis secara Real-Time**: 
  - Perhitungan **Subtotal**, penambahan **PPN 11%**, dan total keseluruhan (Total Akhir).
  - Perhitungan **Uang Kembalian** otomatis saat kasir menginput nominal uang yang diterima dari pelanggan.
- **Metode Pembayaran Tunai (Cash Only)**: Konfigurasi sistem disesuaikan secara khusus untuk merespon penerimaan pembayaran Tunai secara efisien.
- **Struk Digital (Print Preview)**: Setelah transaksi divalidasi (uang mencukupi dan keranjang tidak kosong), sistem akan menampilkan halaman pop-up/preview Struk Pembayaran yang siap untuk dihubungkan dengan mesin printer.

## Struktur Direktori

Proyek ini dibangun menggunakan arsitektur MVC sederhana berbasis `Provider` untuk state management yang mudah di-maintain:

```text
kasir_bengkel/
│
├── assets/                     # Penyimpanan file statis (gambar, icon, dll)
├── lib/
│   ├── models/                 # Model data (Layanan, Pelanggan, Pesanan)
│   ├── screens/                # UI Utama (KasirScreen, StrukScreen)
│   ├── widgets/                # Komponen UI Reusable (ItemCard, CartRow, PaymentBox)
│   ├── controllers/            # Logika bisnis dan State Management (KasirController)
│   ├── utils/                  # Helper fungsi (AppFormatters, AppColors)
│   └── main.dart               # Entry Point aplikasi Flutter
└── pubspec.yaml                # Pengaturan dependensi & assets
```

## Teknologi yang Digunakan

- **Framework**: Flutter (Dart)
- **State Management**: Provider (`provider: ^6.1.2`)
- **Formatting**: Intl (`intl: ^0.19.0`) - Digunakan untuk formatting Rupiah (Rp) dan Tanggal lokal.

## Panduan Instalasi dan Menjalankan Aplikasi

1. **Pastikan Anda memiliki Flutter SDK terinstal** di sistem Anda (mendukung Flutter Web).
2. Clone atau ekstrak repositori proyek ini.
3. Buka terminal/command prompt dan arahkan ke root direktori proyek (`kasir_bengkel`).
4. Unduh semua dependensi paket dengan perintah:
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi di browser Chrome untuk lingkungan development:
   ```bash
   flutter run -d chrome
   ```
6. Aplikasi akan terbuka secara otomatis di browser Anda.

## Alur Penggunaan Aplikasi (User Flow)

1. **Input Data Pelanggan**: Masukkan Nopol dan data diri pelanggan (opsional namun direkomendasikan).
2. **Pilih Layanan**: Klik tombol **`+`** pada kartu layanan/suku cadang untuk memasukkannya ke dalam Ringkasan Pesanan (Keranjang). Gunakan fitur pencarian jika perlu.
3. **Pembayaran**: Pada panel bawah kanan, perhatikan Total Akhir, lalu masukkan nominal uang yang diberikan pelanggan ke dalam kotak input **Uang Diterima**. Uang kembalian akan otomatis muncul.
4. **Cetak Struk**: Klik tombol hijau **Cetak Struk & Selesai**. Anda akan diarahkan ke halaman *Preview Struk*.
5. **Selesai**: Klik Cetak & Selesai di halaman struk untuk mereset seluruh halaman kasir kembali kosong untuk pelanggan berikutnya. Jika terjadi kesalahan, Anda juga bisa langsung menekan **Batal Transaksi** di layar utama.
