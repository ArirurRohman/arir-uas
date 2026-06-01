class Layanan {
  final String id;
  final String nama;
  final double harga;
  final dynamic icon; // Menggunakan dynamic agar bisa IconData atau path string

  Layanan({
    required this.id,
    required this.nama,
    required this.harga,
    required this.icon,
  });
}
