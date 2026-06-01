import 'package:flutter/material.dart';
import '../models/layanan.dart';
import '../models/pelanggan.dart';
import '../models/pesanan.dart';

class KasirController extends ChangeNotifier {
  Pelanggan pelanggan = Pelanggan();
  List<Pesanan> keranjang = [];
  double uangDiterima = 0;

  List<Layanan> daftarLayanan = [
    Layanan(id: '1', nama: 'Tune Up', harga: 250000, icon: Icons.build),
    Layanan(id: '2', nama: 'Ganti Oli', harga: 50000, icon: Icons.water_drop),
    Layanan(id: '3', nama: 'Servis Rem', harga: 150000, icon: Icons.settings_applications),
    Layanan(id: '4', nama: 'Oli Mesin 4L', harga: 450000, icon: Icons.oil_barrel),
    Layanan(id: '5', nama: 'Filter Oli', harga: 180000, icon: Icons.construction),
    Layanan(id: '6', nama: 'Balancing', harga: 180000, icon: Icons.tire_repair),
  ];

  String searchQuery = '';
  
  List<Layanan> get layananFiltered {
    if (searchQuery.isEmpty) return daftarLayanan;
    return daftarLayanan
        .where((l) => l.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void updateSearch(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void tambahKeKeranjang(Layanan layanan) {
    int index = keranjang.indexWhere((p) => p.layanan.id == layanan.id);
    if (index >= 0) {
      keranjang[index].qty++;
    } else {
      keranjang.add(Pesanan(layanan: layanan));
    }
    notifyListeners();
  }

  void hapusDariKeranjang(Pesanan pesanan) {
    keranjang.remove(pesanan);
    notifyListeners();
  }

  double get subtotal {
    return keranjang.fold(0, (sum, item) => sum + item.total);
  }

  double get ppn {
    return subtotal * 0.11;
  }

  double get totalAkhir {
    return subtotal + ppn;
  }

  double get kembalian {
    return (uangDiterima - totalAkhir) > 0 ? (uangDiterima - totalAkhir) : 0;
  }

  void updateUangDiterima(String value) {
    String cleanVal = value.replaceAll(RegExp(r'[^0-9]'), '');
    uangDiterima = double.tryParse(cleanVal) ?? 0;
    notifyListeners();
  }

  void updatePelanggan({String? noPolisi, String? nama, String? noHp, String? merk}) {
    if (noPolisi != null) pelanggan.noPolisi = noPolisi;
    if (nama != null) pelanggan.nama = nama;
    if (noHp != null) pelanggan.noHp = noHp;
    if (merk != null) pelanggan.merkTipe = merk;
    notifyListeners();
  }

  void batalTransaksi() {
    pelanggan = Pelanggan();
    keranjang.clear();
    uangDiterima = 0;
    searchQuery = '';
    notifyListeners();
  }
}
