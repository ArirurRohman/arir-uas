import 'package:flutter/material.dart';
import '../models/pesanan.dart';
import '../utils/formatters.dart';
import '../utils/constants.dart';

class CartRow extends StatelessWidget {
  final Pesanan pesanan;
  final VoidCallback onRemove;

  const CartRow({super.key, required this.pesanan, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              pesanan.layanan.nama,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              AppFormatters.formatRupiah(pesanan.layanan.harga),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${pesanan.qty}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              AppFormatters.formatRupiah(pesanan.total),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: onRemove,
            child: const Icon(Icons.delete, color: AppColors.error, size: 20),
          )
        ],
      ),
    );
  }
}
