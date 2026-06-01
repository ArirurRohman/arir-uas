import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../controllers/kasir_controller.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../widgets/item_card.dart';
import '../widgets/cart_row.dart';
import '../widgets/payment_box.dart';
import 'struk_screen.dart';

class KasirScreen extends StatelessWidget {
  const KasirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            const Icon(Icons.directions_car, color: AppColors.accent),
            const SizedBox(width: 8),
            Expanded(
              child: const Text('OtoPro Workshop - KASIR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), overflow: TextOverflow.ellipsis),
            ),
            if (!isMobile) const Spacer(),
            if (!isMobile)
              Flexible(
                child: Text(
                  '${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now())} | ${DateFormat('HH:mm').format(DateTime.now())} WIB',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(color: AppColors.accent, height: 4),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMobile
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDataPelanggan(context, isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildSearchBar(context),
                    const SizedBox(height: 16),
                    _buildGridLayanan(context, isMobile: isMobile),
                    const SizedBox(height: 16),
                    _buildRingkasanPesanan(context, isMobile: isMobile),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Panel
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        _buildDataPelanggan(context, isMobile: isMobile),
                        const SizedBox(height: 16),
                        _buildSearchBar(context),
                        const SizedBox(height: 16),
                        Expanded(child: _buildGridLayanan(context, isMobile: isMobile)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Right Panel
                  Expanded(
                    flex: 3,
                    child: _buildRingkasanPesanan(context, isMobile: isMobile),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildDataPelanggan(BuildContext context, {required bool isMobile}) {
    final controller = context.read<KasirController>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Data Pelanggan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          isMobile
              ? Column(
                  children: [
                    _buildTextField('No. Polisi', (val) => controller.updatePelanggan(noPolisi: val)),
                    const SizedBox(height: 12),
                    _buildTextField('Nama Pelanggan', (val) => controller.updatePelanggan(nama: val), icon: Icons.person_outline),
                    const SizedBox(height: 12),
                    _buildTextField('No. WhatsApp', (val) => controller.updatePelanggan(noHp: val), icon: Icons.chat_bubble_outline),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _buildTextField('No. Polisi', (val) => controller.updatePelanggan(noPolisi: val)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField('Nama Pelanggan', (val) => controller.updatePelanggan(nama: val), icon: Icons.person_outline),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField('No. WhatsApp', (val) => controller.updatePelanggan(noHp: val), icon: Icons.chat_bubble_outline),
                    ),
                  ],
                ),
          const SizedBox(height: 12),
          _buildTextField('Merk/Tipe Mobil', (val) => controller.updatePelanggan(merk: val)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, size: 18) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (val) => context.read<KasirController>().updateSearch(val),
      decoration: InputDecoration(
        hintText: 'Cari Jasa/Suku Cadang',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }

  Widget _buildGridLayanan(BuildContext context, {required bool isMobile}) {
    return Consumer<KasirController>(
      builder: (context, controller, child) {
        return GridView.builder(
          shrinkWrap: isMobile,
          physics: isMobile ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 2,
            childAspectRatio: isMobile ? 4 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: controller.layananFiltered.length,
          itemBuilder: (context, index) {
            return ItemCard(
              layanan: controller.layananFiltered[index],
              onTap: () => controller.tambahKeKeranjang(controller.layananFiltered[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildRingkasanPesanan(BuildContext context, {required bool isMobile}) {
    return Consumer<KasirController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ringkasan Pesanan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                child: const Row(
                  children: [
                    Expanded(flex: 3, child: Text('Item', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('Harga', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 1, child: Text('QTY', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    Expanded(flex: 2, child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    SizedBox(width: 32, child: Text('Aksi', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                  ],
                ),
              ),
              // Items
              isMobile
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.keranjang.length,
                      itemBuilder: (context, index) {
                        final item = controller.keranjang[index];
                        return CartRow(
                          pesanan: item,
                          onRemove: () => controller.hapusDariKeranjang(item),
                        );
                      },
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.keranjang.length,
                        itemBuilder: (context, index) {
                          final item = controller.keranjang[index];
                          return CartRow(
                            pesanan: item,
                            onRemove: () => controller.hapusDariKeranjang(item),
                          );
                        },
                      ),
                    ),
              const Divider(),
              // Totals
              _buildTotalRow('Subtotal:', AppFormatters.formatRupiah(controller.subtotal)),
              const SizedBox(height: 4),
              _buildTotalRow('PPN (11%):', AppFormatters.formatRupiah(controller.ppn)),
              const SizedBox(height: 8),
              _buildTotalRow('TOTAL AKHIR:', AppFormatters.formatRupiah(controller.totalAkhir), isBold: true, valueSize: 18),
              const SizedBox(height: 16),
              // Payment Box
              PaymentBox(
                onUangChanged: controller.updateUangDiterima,
                kembalian: AppFormatters.formatRupiah(controller.kembalian),
                onCetak: () {
                  if (controller.keranjang.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Keranjang masih kosong')),
                    );
                    return;
                  }
                  if (controller.uangDiterima < controller.totalAkhir) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Uang yang diterima kurang')),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StrukScreen()),
                  );
                },
                onBatal: () {
                  controller.batalTransaksi();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false, double valueSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 16 : 14),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 120,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: valueSize),
          ),
        ),
      ],
    );
  }
}
