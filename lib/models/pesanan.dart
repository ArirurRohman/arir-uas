import 'layanan.dart';

class Pesanan {
  final Layanan layanan;
  int qty;

  Pesanan({
    required this.layanan,
    this.qty = 1,
  });

  double get total => layanan.harga * qty;
}
