import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controllers/kasir_controller.dart';
import '../utils/formatters.dart';

class StrukScreen extends StatelessWidget {
  const StrukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<KasirController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Struk'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
            children: [
              const Text('OTOPRO WORKSHOP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('Jl. Raya Bengkel No. 123, Kota Mobil'),
              const Text('Telp: 0812-3456-7890'),
              const SizedBox(height: 16),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Tanggal: ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}')),
                  const Text('Kasir: Admin'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Pelanggan: ${controller.pelanggan.nama.isEmpty ? '-' : controller.pelanggan.nama}', overflow: TextOverflow.ellipsis)),
                  const SizedBox(width: 8),
                  Text('Nopol: ${controller.pelanggan.noPolisi.isEmpty ? '-' : controller.pelanggan.noPolisi}'),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              ...controller.keranjang.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: Text(item.layanan.nama)),
                    Expanded(flex: 1, child: Text('${item.qty} x', textAlign: TextAlign.center)),
                    Expanded(flex: 2, child: Text(AppFormatters.formatRupiah(item.layanan.harga), textAlign: TextAlign.right)),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              _buildStrukRow('Subtotal', AppFormatters.formatRupiah(controller.subtotal)),
              _buildStrukRow('PPN (11%)', AppFormatters.formatRupiah(controller.ppn)),
              const SizedBox(height: 8),
              _buildStrukRow('TOTAL', AppFormatters.formatRupiah(controller.totalAkhir), isBold: true),
              const SizedBox(height: 8),
              const Divider(thickness: 2),
              const SizedBox(height: 8),
              _buildStrukRow('Tunai', AppFormatters.formatRupiah(controller.uangDiterima)),
              _buildStrukRow('Kembali', AppFormatters.formatRupiah(controller.kembalian)),
              const SizedBox(height: 24),
              const Text('TERIMA KASIH ATAS KUNJUNGAN ANDA', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  controller.batalTransaksi();
                  Navigator.pop(context);
                },
                child: const Text('Cetak & Selesai'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildStrukRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal))),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
