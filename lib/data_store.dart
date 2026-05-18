import 'package:flutter/material.dart';

class ServiceLog {
  final String title;
  final String subtitle;
  final String price;
  final double costValue; // Numeric value for calculations
  final IconData icon;
  final Color color;
  final bool showIndicator;
  final DateTime date;

  ServiceLog({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.costValue,
    required this.icon,
    this.color = Colors.red,
    this.showIndicator = false,
    required this.date,
  });
}

class Localization {
  static final Map<String, Map<String, String>> _localizedValues = {
    'English (US)': {
      // General Navigation & Titles
      'settings': 'SETTINGS',
      'account': 'ACCOUNT',
      'profile_info': 'Profile Information',
      'security_pass': 'Security & Password',
      'preferences': 'PREFERENCES',
      'notifications': 'Notifications',
      'unit_system': 'Unit System',
      'language': 'Language',
      'data_mgmt': 'DATA MANAGEMENT',
      'export_data': 'Export Data',
      'clear_logs': 'Clear Logs',
      'about': 'ABOUT',
      'version': 'Version',
      'tos': 'Terms of Service',
      'garage': 'Garage',
      'service': 'Service',
      'stats': 'Stats',
      
      // Home Screen / Dashboard
      'active_garage': 'ACTIVE GARAGE',
      'view_all': 'VIEW ALL',
      'recent_services': 'RECENT SERVICES',
      'view_full_history': 'VIEW FULL HISTORY',
      'in_service': 'IN SERVICE',
      'filter_services': 'FILTER SERVICES',
      'all_services': 'All Services',
      'maintenance': 'Maintenance',
      'repairs': 'Repairs',
      'inspections': 'Inspections',
      'detailed_info': 'Detailed information about {} will be displayed here.',
      
      // Drawer
      'menu_garage': 'GARAGE',
      'menu_history': 'HISTORY',
      'menu_analytics': 'ANALYTICS',
      'menu_logout': 'LOGOUT',
      
      // Stats / Analytics Screen
      'perf_stats': 'PERFORMANCE STATS',
      'total_invested': 'TOTAL INVESTED',
      'total_logs': 'TOTAL LOGS',
      'vehicles': 'VEHICLES',
      'maint_metrics': 'MAINTENANCE METRICS',
      'cost_breakdown': 'COST BREAKDOWN',
      'metric_efficiency': 'EFFICIENCY',
      'metric_uptime': 'UPTIME',
      'metric_health': 'HEALTH',
      'metric_value': 'VALUE',
      'metric_health_val': 'EXCELLENT',
      'br_engine': 'Engine Maintenance',
      'br_suspension': 'Suspension & Tires',
      'br_electronics': 'Electronics',
      'br_other': 'Other',
      'no_history': 'No service history found.',
      
      // Add Service Screen & Dialogs
      'service_center': 'SERVICE CENTER',
      'add_service_log': 'Add Service Log',
      'document_precise': "Document your vehicle's maintenance with technical precision.",
      'service_name': 'SERVICE NAME',
      'service_date': 'SERVICE DATE',
      'cost_idr': 'BIAYA (IDR)',
      'service_notes': 'SERVICE NOTES',
      'technical_insight': 'Technical Insight',
      'resale_value': "Maintaining a digital log increases your vehicle's resale value.",
      'quick_templates': 'QUICK TEMPLATES',
      'save_log': 'SAVE LOG',
      'enter_name_error': 'Please enter a service name.',
      'select_date_error': 'Please select a service date.',
      'template_applied': 'Template "{}" applied.',
      
      // Settings dialog details & toasts
      'info_profile': 'Edit your name and avatar',
      'info_security': 'Update your login credentials',
      'info_export': 'Download all service logs',
      'info_clear': 'Permanently delete all data',
      'info_version': 'System diagnostics and version details',
      'info_tos': 'Review legal agreements',
      'toast_profile': 'Profile updated successfully!',
      'toast_pass': 'Password updated successfully!',
      'toast_clear': 'All logs successfully cleared.',
      'toast_save': 'Service log saved successfully!',
      'export_desc': 'Copy the JSON data below to backup your logs:',
      'clear_confirm': 'Are you sure you want to permanently delete all service logs? This action cannot be undone.',
      'clear_btn': 'DELETE ALL',
      'profile_title': 'PROFILE INFORMATION',
      'sec_title': 'SECURITY & PASSWORD',
      'diag_title': 'SYSTEM DIAGNOSTICS',
      'cancel': 'CANCEL',
      'save': 'SAVE',
      'update': 'UPDATE',
      'close': 'CLOSE',
    },
    'Bahasa Indonesia': {
      // General Navigation & Titles
      'settings': 'PENGATURAN',
      'account': 'AKUN',
      'profile_info': 'Informasi Profil',
      'security_pass': 'Keamanan & Kata Sandi',
      'preferences': 'PREFERENSI',
      'notifications': 'Notifikasi',
      'unit_system': 'Sistem Satuan',
      'language': 'Bahasa',
      'data_mgmt': 'MANAJEMEN DATA',
      'export_data': 'Ekspor Data',
      'clear_logs': 'Hapus Semua Log',
      'about': 'TENTANG',
      'version': 'Versi',
      'tos': 'Ketentuan Layanan',
      'garage': 'Garasi',
      'service': 'Servis',
      'stats': 'Statistik',
      
      // Home Screen / Dashboard
      'active_garage': 'GARASI AKTIF',
      'view_all': 'LIHAT SEMUA',
      'recent_services': 'SERVIS TERBARU',
      'view_full_history': 'LIHAT SEMUA RIWAYAT',
      'in_service': 'DALAM PERBAIKAN',
      'filter_services': 'FILTER LAYANAN',
      'all_services': 'Semua Layanan',
      'maintenance': 'Pemeliharaan',
      'repairs': 'Perbaikan',
      'inspections': 'Pemeriksaan',
      'detailed_info': 'Informasi terperinci mengenai {} akan ditampilkan di sini.',
      
      // Drawer
      'menu_garage': 'GARASI',
      'menu_history': 'RIWAYAT',
      'menu_analytics': 'ANALISIS',
      'menu_logout': 'KELUAR',
      
      // Stats / Analytics Screen
      'perf_stats': 'STATISTIK KINERJA',
      'total_invested': 'TOTAL INVESTASI',
      'total_logs': 'TOTAL LOG',
      'vehicles': 'KENDARAAN',
      'maint_metrics': 'METRIK PEMELIHARAAN',
      'cost_breakdown': 'RIWAYAT BIAYA',
      'metric_efficiency': 'EFISIENSI',
      'metric_uptime': 'WAKTU AKTIF',
      'metric_health': 'KESEHATAN',
      'metric_value': 'NILAI',
      'metric_health_val': 'SANGAT BAIK',
      'br_engine': 'Perawatan Mesin',
      'br_suspension': 'Suspensi & Ban',
      'br_electronics': 'Elektronik',
      'br_other': 'Lain-lain',
      'no_history': 'Riwayat servis kosong.',
      
      // Add Service Screen & Dialogs
      'service_center': 'PUSAT SERVIS',
      'add_service_log': 'Tambah Log Servis',
      'document_precise': "Dokumentasikan pemeliharaan kendaraan Anda dengan presisi teknis.",
      'service_name': 'NAMA SERVIS',
      'service_date': 'TANGGAL SERVIS',
      'cost_idr': 'BIAYA (IDR)',
      'service_notes': 'CATATAN SERVIS',
      'technical_insight': 'Wawasan Teknis',
      'resale_value': "Menjaga log digital meningkatkan nilai jual kembali kendaraan Anda.",
      'quick_templates': 'TEMPLAT CEPAT',
      'save_log': 'SIMPAN LOG',
      'enter_name_error': 'Silakan masukkan nama servis.',
      'select_date_error': 'Silakan pilih tanggal servis.',
      'template_applied': 'Templat "{}" diterapkan.',
      
      // Settings dialog details & toasts
      'info_profile': 'Ubah nama dan foto profil Anda',
      'info_security': 'Perbarui detail keamanan masuk Anda',
      'info_export': 'Unduh semua log servis Anda',
      'info_clear': 'Hapus permanen semua data log',
      'info_version': 'Diagnostik sistem dan detail versi',
      'info_tos': 'Tinjau perjanjian hukum kami',
      'toast_profile': 'Profil berhasil diperbarui!',
      'toast_pass': 'Kata sandi berhasil diperbarui!',
      'toast_clear': 'Semua log berhasil dihapus.',
      'toast_save': 'Log servis berhasil disimpan!',
      'export_desc': 'Salin data JSON di bawah untuk mencadangkan log Anda:',
      'clear_confirm': 'Apakah Anda yakin ingin menghapus semua log servis secara permanen? Tindakan ini tidak dapat dibatalkan.',
      'clear_btn': 'HAPUS SEMUA',
      'profile_title': 'INFORMASI PROFIL',
      'sec_title': 'KEAMANAN & KATA SANDI',
      'diag_title': 'DIAGNOSTIK SISTEM',
      'cancel': 'BATAL',
      'save': 'SIMPAN',
      'update': 'PERBARUI',
      'close': 'TUTUP',
    }
  };

  static String translate(String lang, String key, [String? arg]) {
    String text = _localizedValues[lang]?[key] ?? key;
    if (arg != null) {
      text = text.replaceAll('{}', arg);
    }
    return text;
  }
}

class DataStore {
  static final DataStore _instance = DataStore._internal();
  factory DataStore() => _instance;
  DataStore._internal();

  final ValueNotifier<String> languageNotifier = ValueNotifier<String>('English (US)');

  final ValueNotifier<List<ServiceLog>> servicesNotifier = ValueNotifier<List<ServiceLog>>([
    ServiceLog(
      title: 'Shell Helix Oil Change',
      subtitle: 'OCT 24, 2023 • MAINTENANCE',
      price: 'Rp 1.850.000',
      costValue: 1850000,
      icon: Icons.oil_barrel,
      date: DateTime(2023, 10, 24),
    ),
    ServiceLog(
      title: 'Brake Pad Replacement',
      subtitle: 'SEP 12, 2023 • REPAIR',
      price: 'Rp 4.200.500',
      costValue: 4200500,
      icon: Icons.album_outlined,
      showIndicator: true,
      date: DateTime(2023, 9, 12),
    ),
    ServiceLog(
      title: 'Wheel Alignment',
      subtitle: 'AUG 05, 2023 • MAINTENANCE',
      price: 'Rp 1.200.000',
      costValue: 1200000,
      icon: Icons.settings_input_component,
      date: DateTime(2023, 8, 5),
    ),
    ServiceLog(
      title: 'ECU Diagnostics',
      subtitle: 'JUL 18, 2023 • INSPECTION',
      price: 'Rp 850.000',
      costValue: 850000,
      icon: Icons.analytics,
      date: DateTime(2023, 7, 18),
    ),
  ]);

  void addService(ServiceLog service) {
    servicesNotifier.value = [service, ...servicesNotifier.value];
  }
}
