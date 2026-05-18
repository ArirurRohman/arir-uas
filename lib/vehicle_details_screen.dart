import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'placeholder_screens.dart';
import 'add_service_screen.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: DataStore().languageNotifier,
      builder: (context, lang, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section with Image and Titles
                Stack(
                  children: [
                    Image.asset(
                      'assets/car_gtr.png',
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF0D0D0D).withOpacity(0.5),
                              const Color(0xFF0D0D0D),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              lang == 'Bahasa Indonesia' ? 'KENDARAAN AKTIF' : 'CURRENT VEHICLE',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'NISSAN GTR R35',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Summary Card (Red)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Abstract Background Graphic
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Icon(
                          Icons.insights,
                          size: 100,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang == 'Bahasa Indonesia' ? 'TOTAL BIAYA SERVIS' : 'TOTAL SERVICE COST',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp 8.100.500',
                                style: GoogleFonts.orbitron(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              _buildMiniStat(lang == 'Bahasa Indonesia' ? 'LOG' : 'LOGS', '4'),
                              const SizedBox(width: 30),
                              _buildMiniStat(Localization.translate(lang, 'metric_efficiency'), '98%'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Odometer Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ODOMETER',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.speed, color: Colors.red, size: 18),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        '12,500',
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        lang == 'Bahasa Indonesia' ? 'KILOMETER' : 'KILOMETERS',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Progress Bar
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.25,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        lang == 'Bahasa Indonesia' ? 'BERIKUTNYA: 15.000 KM' : 'NEXT MAJOR: 15,000 KM',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Service Logs Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 3,
                            height: 20,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            lang == 'Bahasa Indonesia' ? 'LOG SERVIS KENDARAAN' : 'VEHICLE SERVICE LOGS',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()));
                        },
                        child: Row(
                          children: [
                            Text(
                              Localization.translate(lang, 'view_all'),
                              style: GoogleFonts.inter(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward, color: Colors.red, size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Detailed Logs List
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      DetailedLogTile(
                        title: 'Shell Helix Oil Change',
                        details: lang == 'Bahasa Indonesia' ? 'Oli Shell Helix Kelas Balap • 12,200 km' : 'Synthetic Shell Helix • 12,200 km',
                        date: 'OCT 24, 2023',
                        price: 'Rp 1.850.000',
                        badges: [lang == 'Bahasa Indonesia' ? 'PEMELIHARAAN' : 'MAINTENANCE', lang == 'Bahasa Indonesia' ? 'SELESAI' : 'COMPLETED'],
                        icon: Icons.build,
                      ),
                      DetailedLogTile(
                        title: 'Brake Pad Replacement',
                        details: lang == 'Bahasa Indonesia' ? 'Kampas Rem Brembo Kinerja Tinggi • 10,500 km' : 'Brembo High Performance Pads • 10,500 km',
                        date: 'SEP 12, 2023',
                        price: 'Rp 4.200.500',
                        badges: [lang == 'Bahasa Indonesia' ? 'PERFORMA' : 'PERFORMANCE', lang == 'Bahasa Indonesia' ? 'SELESAI' : 'COMPLETED'],
                        icon: Icons.directions_car,
                      ),
                      DetailedLogTile(
                        title: 'Wheel Alignment',
                        details: lang == 'Bahasa Indonesia' ? 'Penyelarasan Roda 3D • 8.500 km' : '3D Wheel Alignment • 8,500 km',
                        date: 'AUG 05, 2023',
                        price: 'Rp 1.200.000',
                        badges: [lang == 'Bahasa Indonesia' ? 'PEMELIHARAAN' : 'MAINTENANCE', lang == 'Bahasa Indonesia' ? 'SELESAI' : 'COMPLETED'],
                        icon: Icons.warning_amber_rounded,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(canvasColor: const Color(0xFF141414)),
            child: BottomNavigationBar(
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddServiceScreen()));
                } else if (index == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen()));
                } else if (index == 3) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                }
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(icon: const Icon(Icons.garage), label: Localization.translate(lang, 'garage')),
                BottomNavigationBarItem(icon: const Icon(Icons.build), label: Localization.translate(lang, 'service')),
                BottomNavigationBarItem(icon: const Icon(Icons.show_chart), label: Localization.translate(lang, 'stats')),
                BottomNavigationBarItem(icon: const Icon(Icons.settings), label: Localization.translate(lang, 'settings')),
              ],
            ),
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
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.6),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DetailedLogTile extends StatelessWidget {
  final String title;
  final String details;
  final String date;
  final String price;
  final List<String> badges;
  final IconData icon;

  const DetailedLogTile({
    super.key,
    required this.title,
    required this.details,
    required this.date,
    required this.price,
    required this.badges,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.red, size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      details,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: badges.map((badge) {
                        bool isCompleted = badge == 'COMPLETED' || badge == 'SELESAI';
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.inter(
                              color: isCompleted ? Colors.green : Colors.white.withOpacity(0.6),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: GoogleFonts.orbitron(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
