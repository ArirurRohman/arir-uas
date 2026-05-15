import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'home_screen.dart'; // To reuse ServiceTile if possible, or we can define it locally

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
    return const _PlaceholderScaffold(title: 'PERFORMANCE STATS', icon: Icons.show_chart);
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
