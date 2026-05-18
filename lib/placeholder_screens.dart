import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';

class GarageListScreen extends StatelessWidget {
  const GarageListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DataStore().languageNotifier,
      builder: (context, lang, child) {
        return _PlaceholderScaffold(
          title: lang == 'Bahasa Indonesia' ? 'SEMUA KENDARAAN' : 'ALL VEHICLES',
          icon: Icons.garage,
        );
      }
    );
  }
}

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DataStore().languageNotifier,
      builder: (context, lang, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              Localization.translate(lang, 'menu_history'),
              style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
          body: ValueListenableBuilder<List<ServiceLog>>(
            valueListenable: DataStore().servicesNotifier,
            builder: (context, services, child) {
              if (services.isEmpty) {
                return Center(
                  child: Text(
                    Localization.translate(lang, 'no_history'),
                    style: GoogleFonts.inter(color: Colors.white54),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final log = services[index];
                  return ServiceTile(
                    title: log.title,
                    subtitle: log.subtitle,
                    price: log.price,
                    icon: log.icon,
                    color: log.color,
                    showIndicator: log.showIndicator,
                  );
                },
              );
            },
          ),
        );
      }
    );
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return ValueListenableBuilder<String>(
      valueListenable: DataStore().languageNotifier,
      builder: (context, lang, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              Localization.translate(lang, 'perf_stats'),
              style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
          body: ValueListenableBuilder<List<ServiceLog>>(
            valueListenable: DataStore().servicesNotifier,
            builder: (context, services, child) {
              double totalCost = services.fold(0, (sum, item) => sum + item.costValue);
              int totalServices = services.length;
              
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total Spending Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Localization.translate(lang, 'total_invested'),
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currencyFormat.format(totalCost),
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              _buildMiniStat(Localization.translate(lang, 'total_logs'), totalServices.toString()),
                              const SizedBox(width: 40),
                              _buildMiniStat(Localization.translate(lang, 'vehicles'), '1'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      Localization.translate(lang, 'maint_metrics'),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Metrics Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.5,
                      children: [
                        _buildMetricCard(Localization.translate(lang, 'metric_efficiency'), '98%', Icons.bolt, Colors.amber),
                        _buildMetricCard(Localization.translate(lang, 'metric_uptime'), '100%', Icons.timer, Colors.green),
                        _buildMetricCard(Localization.translate(lang, 'metric_health'), Localization.translate(lang, 'metric_health_val'), Icons.favorite, Colors.red),
                        _buildMetricCard(Localization.translate(lang, 'metric_value'), '+12%', Icons.trending_up, Colors.blue),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Spending Breakdown
                    Text(
                      Localization.translate(lang, 'cost_breakdown'),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Column(
                        children: [
                          _buildBreakdownItem(Localization.translate(lang, 'br_engine'), 0.65, Colors.red),
                          _buildBreakdownItem(Localization.translate(lang, 'br_suspension'), 0.20, Colors.blue),
                          _buildBreakdownItem(Localization.translate(lang, 'br_electronics'), 0.10, Colors.green),
                          _buildBreakdownItem(Localization.translate(lang, 'br_other'), 0.05, Colors.grey),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: GoogleFonts.orbitron(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.orbitron(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, double percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.inter(color: Colors.white70, fontSize: 12)),
              Text('${(percentage * 100).toInt()}%', style: GoogleFonts.inter(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _selectedUnit = 'Metric (km/Celsius)';
  String _userName = 'Alex Gearhead';

  void _showProfileDialog(String lang) {
    final controller = TextEditingController(text: _userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'profile_title'), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: lang == 'Bahasa Indonesia' ? 'Nama Pengguna' : 'User Name',
                labelStyle: const TextStyle(color: Colors.white60),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'cancel'), style: const TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _userName = controller.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Localization.translate(lang, 'toast_profile')), backgroundColor: Colors.green),
              );
            },
            child: Text(Localization.translate(lang, 'save'), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSecurityDialog(String lang) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'sec_title'), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: lang == 'Bahasa Indonesia' ? 'Kata Sandi Saat Ini' : 'Current Password',
                labelStyle: const TextStyle(color: Colors.white60),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: lang == 'Bahasa Indonesia' ? 'Kata Sandi Baru' : 'New Password',
                labelStyle: const TextStyle(color: Colors.white60),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'cancel'), style: const TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Localization.translate(lang, 'toast_pass')), backgroundColor: Colors.green),
              );
            },
            child: Text(Localization.translate(lang, 'update'), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showUnitDialog(String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'unit_system').toUpperCase(), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('Metric (km/Celsius)', style: TextStyle(color: Colors.white)),
                  value: 'Metric (km/Celsius)',
                  groupValue: _selectedUnit,
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      _selectedUnit = val!;
                    });
                    setDialogState(() {});
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Imperial (miles/Fahrenheit)', style: TextStyle(color: Colors.white)),
                  value: 'Imperial (miles/Fahrenheit)',
                  groupValue: _selectedUnit,
                  activeColor: Colors.red,
                  onChanged: (val) {
                    setState(() {
                      _selectedUnit = val!;
                    });
                    setDialogState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void _showLanguageDialog(String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'language').toUpperCase(), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: StatefulBuilder(
          builder: (context, setDialogState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('English (US)', style: TextStyle(color: Colors.white)),
                  value: 'English (US)',
                  groupValue: DataStore().languageNotifier.value,
                  activeColor: Colors.red,
                  onChanged: (val) {
                    DataStore().languageNotifier.value = val!;
                    setDialogState(() {});
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Bahasa Indonesia', style: TextStyle(color: Colors.white)),
                  value: 'Bahasa Indonesia',
                  groupValue: DataStore().languageNotifier.value,
                  activeColor: Colors.red,
                  onChanged: (val) {
                    DataStore().languageNotifier.value = val!;
                    setDialogState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void _exportData(String lang) {
    final logs = DataStore().servicesNotifier.value;
    String data = '[\n';
    for (var log in logs) {
      data += '  {\n';
      data += '    "title": "${log.title}",\n';
      data += '    "subtitle": "${log.subtitle}",\n';
      data += '    "price": "${log.price}",\n';
      data += '    "costValue": ${log.costValue},\n';
      data += '    "date": "${log.date.toIso8601String()}"\n';
      data += '  },\n';
    }
    if (logs.isNotEmpty) {
      data = data.substring(0, data.length - 2) + '\n';
    }
    data += ']';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'export_data').toUpperCase(), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Localization.translate(lang, 'export_desc'), style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  data,
                  style: const TextStyle(color: Colors.green, fontFamily: 'monospace', fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'close'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _clearLogs(String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'clear_logs').toUpperCase(), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: Text(
          Localization.translate(lang, 'clear_confirm'),
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'cancel'), style: const TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              DataStore().servicesNotifier.value = [];
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(Localization.translate(lang, 'toast_clear')), backgroundColor: Colors.red),
              );
            },
            child: Text(Localization.translate(lang, 'clear_btn'), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'tos').toUpperCase(), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Text(
            lang == 'Bahasa Indonesia'
              ? 'Selamat datang di Gearhead.\n\n'
                '1. Penerimaan Ketentuan\n'
                'Dengan menggunakan aplikasi seluler Gearhead, Anda setuju untuk mematuhi dan terikat oleh ketentuan ini.\n\n'
                '2. Kepemilikan Data\n'
                'Semua log kendaraan, metrik, dan diagnostik disimpan secara lokal di perangkat Anda. Anda bertanggung jawab penuh untuk mencadangkan data Anda.\n\n'
                '3. Akurasi Sistem\n'
                'Diagnostik, metrik, dan perhitungan efisiensi hanya sebagai referensi. Konsultasikan dengan teknisi otomotif bersertifikat untuk kondisi kendaraan yang tepat.'
              : 'Welcome to Gearhead.\n\n'
                '1. Acceptance of Terms\n'
                'By using the Gearhead mobile application, you agree to comply with and be bound by these terms.\n\n'
                '2. Data Ownership\n'
                'All vehicle logs, metrics, and diagnostics are stored locally on your device. You are fully responsible for backing up your data.\n\n'
                '3. System Accuracy\n'
                'Diagnostics, metrics, and efficiency calculations are for reference only. Consult certified automotive technicians for exact vehicle states.',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'close'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showVersionDialog(String lang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(Localization.translate(lang, 'diag_title'), style: GoogleFonts.orbitron(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${lang == 'Bahasa Indonesia' ? 'Versi Aplikasi' : 'App Version'}: v1.0.4-build.2024', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text('Database: Local SQLite (Sync OK)', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text('${lang == 'Bahasa Indonesia' ? 'Penggunaan Memori' : 'Memory Usage'}: 42 MB', style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text('API Status: Operational', style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(Localization.translate(lang, 'close'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DataStore().languageNotifier,
      builder: (context, lang, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              Localization.translate(lang, 'settings'),
              style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildSettingsHeader(Localization.translate(lang, 'account')),
              _buildSettingsItem(
                Icons.person_outline,
                Localization.translate(lang, 'profile_info'),
                _userName,
                onTap: () => _showProfileDialog(lang),
              ),
              _buildSettingsItem(
                Icons.lock_outline,
                Localization.translate(lang, 'security_pass'),
                Localization.translate(lang, 'info_security'),
                onTap: () => _showSecurityDialog(lang),
              ),
              
              const SizedBox(height: 30),
              _buildSettingsHeader(Localization.translate(lang, 'preferences')),
              _buildSettingsItem(
                Icons.notifications_outlined,
                Localization.translate(lang, 'notifications'),
                _notificationsEnabled
                    ? (lang == 'Bahasa Indonesia' ? 'Aktif' : 'Enabled')
                    : (lang == 'Bahasa Indonesia' ? 'Nonaktif' : 'Disabled'),
                trailing: Switch(
                  value: _notificationsEnabled,
                  activeColor: Colors.red,
                  inactiveTrackColor: Colors.white24,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
              ),
              _buildSettingsItem(
                Icons.straighten,
                Localization.translate(lang, 'unit_system'),
                _selectedUnit,
                onTap: () => _showUnitDialog(lang),
              ),
              _buildSettingsItem(
                Icons.language,
                Localization.translate(lang, 'language'),
                lang,
                onTap: () => _showLanguageDialog(lang),
              ),
              
              const SizedBox(height: 30),
              _buildSettingsHeader(Localization.translate(lang, 'data_mgmt')),
              _buildSettingsItem(
                Icons.cloud_upload_outlined,
                Localization.translate(lang, 'export_data'),
                Localization.translate(lang, 'info_export'),
                onTap: () => _exportData(lang),
              ),
              _buildSettingsItem(
                Icons.delete_outline,
                Localization.translate(lang, 'clear_logs'),
                Localization.translate(lang, 'info_clear'),
                color: Colors.red,
                onTap: () => _clearLogs(lang),
              ),
              
              const SizedBox(height: 30),
              _buildSettingsHeader(Localization.translate(lang, 'about')),
              _buildSettingsItem(
                Icons.info_outline,
                Localization.translate(lang, 'version'),
                '1.0.4-build.2024',
                onTap: () => _showVersionDialog(lang),
              ),
              _buildSettingsItem(
                Icons.description_outlined,
                Localization.translate(lang, 'tos'),
                Localization.translate(lang, 'info_tos'),
                onTap: () => _showTermsDialog(lang),
              ),
              
              const SizedBox(height: 50),
              Center(
                child: Text(
                  'GEARHEAD V1.0.4',
                  style: GoogleFonts.orbitron(color: Colors.white24, fontSize: 10, letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }
    );
  }

  Widget _buildSettingsHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle, {
    Color color = Colors.white70,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color == Colors.red ? Colors.red : Colors.white60, size: 20),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.inter(color: Colors.white38, fontSize: 11),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
        onTap: onTap,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderScaffold(title: 'USER PROFILE', icon: Icons.person);
  }
}

class _PlaceholderScaffold extends StatelessWidget {
  final String title;
  final IconData icon;

  const _PlaceholderScaffold({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.red.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'FEATURE COMING SOON',
              style: GoogleFonts.inter(color: Colors.white54, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
