import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'vehicle_details_screen.dart';
import 'add_service_screen.dart';
import 'placeholder_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FILTER SERVICES',
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              _buildFilterOption('All Services', Icons.list, true),
              _buildFilterOption('Maintenance', Icons.build, false),
              _buildFilterOption('Repairs', Icons.handyman, false),
              _buildFilterOption('Inspections', Icons.analytics, false),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, IconData icon, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.red : Colors.grey),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.red) : null,
      onTap: () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0D0D0D),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0D0D0D),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: Center(
                child: Text(
                  'GEARHEAD',
                  style: GoogleFonts.orbitron(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(Icons.garage, 'GARAGE', () => Navigator.pop(context)),
            _buildDrawerItem(Icons.history, 'HISTORY', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()));
            }),
            _buildDrawerItem(Icons.analytics, 'ANALYTICS', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen()));
            }),
            const Spacer(),
            _buildDrawerItem(Icons.logout, 'LOGOUT', () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          'GEARHEAD',
          style: GoogleFonts.orbitron(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Garage Header
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ACTIVE GARAGE',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GarageListScreen()));
                    },
                    child: Text(
                      'VIEW ALL',
                      style: GoogleFonts.inter(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Car Card
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VehicleDetailsScreen()),
                );
              },
              child: const ActiveCarCard(),
            ),
            
            const SizedBox(height: 30),

            // Recent Services Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT SERVICES',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white, size: 20),
                    onPressed: _showFilterSheet,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Service List
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                ServiceTile(
                  title: 'Shell Helix Oil Change',
                  subtitle: 'OCT 24, 2023 • MAINTENANCE',
                  price: '\$185.00',
                  icon: Icons.oil_barrel,
                  color: Colors.red,
                  onTap: () => _showServiceDetail(context, 'Oil Change'),
                ),
                ServiceTile(
                  title: 'Brake Pad Replacement',
                  subtitle: 'SEP 12, 2023 • REPAIR',
                  price: '\$420.50',
                  icon: Icons.album_outlined,
                  color: Colors.red,
                  showIndicator: true,
                  onTap: () => _showServiceDetail(context, 'Brake Pads'),
                ),
                ServiceTile(
                  title: 'Wheel Alignment',
                  subtitle: 'AUG 05, 2023 • MAINTENANCE',
                  price: '\$120.00',
                  icon: Icons.settings_input_component,
                  color: Colors.red,
                  onTap: () => _showServiceDetail(context, 'Alignment'),
                ),
                ServiceTile(
                  title: 'ECU Diagnostics',
                  subtitle: 'JUL 18, 2023 • INSPECTION',
                  price: '\$85.00',
                  icon: Icons.analytics,
                  color: Colors.red,
                  onTap: () => _showServiceDetail(context, 'ECU Diagnostics'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ServiceHistoryScreen()));
                      },
                      child: Text(
                        'VIEW FULL HISTORY',
                        style: GoogleFonts.inter(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddServiceScreen()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color(0xFF141414),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
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
          selectedLabelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.garage), label: 'Garage'),
            BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Service'),
            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Stats'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
      onTap: onTap,
    );
  }

  void _showServiceDetail(BuildContext context, String service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(service, style: GoogleFonts.orbitron(color: Colors.red)),
        content: Text(
          'Detailed information about $service will be displayed here.',
          style: GoogleFonts.inter(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ActiveCarCard extends StatelessWidget {
  const ActiveCarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Image with Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      'assets/car_gtr.png',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'IN SERVICE',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  // Gradient Overlay for bottom text readability
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF1A1A1A).withOpacity(0.8),
                            const Color(0xFF1A1A1A),
                          ],
                          stops: const [0.6, 0.9, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Car Info
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NISSAN',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'GTR R35',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '12,500',
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'KILOMETERS',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Oil Life Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'OIL LIFE',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '82%',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(10, (index) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: index < 8 ? Colors.red : Colors.grey[800],
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final IconData icon;
  final Color color;
  final bool showIndicator;
  final VoidCallback? onTap;

  const ServiceTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.color,
    this.showIndicator = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Stack(
          children: [
            if (showIndicator)
              Positioned(
                left: 0,
                top: 15,
                bottom: 15,
                child: Container(
                  width: 3,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(3)),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 16),
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
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: GoogleFonts.inter(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
