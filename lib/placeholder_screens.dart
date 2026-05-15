import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';

class GarageListScreen extends StatelessWidget {
  const GarageListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderScaffold(title: 'ALL VEHICLES', icon: Icons.garage);
  }
}

class ServiceHistoryScreen extends StatelessWidget {
  const ServiceHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'SERVICE HISTORY',
          style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: ValueListenableBuilder<List<ServiceLog>>(
        valueListenable: DataStore().servicesNotifier,
        builder: (context, services, child) {
          if (services.isEmpty) {
            return Center(
              child: Text('No service history found.', style: GoogleFonts.inter(color: Colors.white54)),
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
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'PERFORMANCE STATS',
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
                        'TOTAL INVESTED',
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
                          _buildMiniStat('TOTAL LOGS', totalServices.toString()),
                          const SizedBox(width: 40),
                          _buildMiniStat('VEHICLES', '1'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Text(
                  'MAINTENANCE METRICS',
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
                    _buildMetricCard('EFFICIENCY', '98%', Icons.bolt, Colors.amber),
                    _buildMetricCard('UPTIME', '100%', Icons.timer, Colors.green),
                    _buildMetricCard('HEALTH', 'EXCELLENT', Icons.favorite, Colors.red),
                    _buildMetricCard('VALUE', '+12%', Icons.trending_up, Colors.blue),
                  ],
                ),

                const SizedBox(height: 30),

                // Spending Breakdown
                Text(
                  'COST BREAKDOWN',
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
                      _buildBreakdownItem('Engine Maintenance', 0.65, Colors.red),
                      _buildBreakdownItem('Suspension & Tires', 0.20, Colors.blue),
                      _buildBreakdownItem('Electronics', 0.10, Colors.green),
                      _buildBreakdownItem('Other', 0.05, Colors.grey),
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

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const _PlaceholderScaffold(title: 'SETTINGS', icon: Icons.settings);
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
