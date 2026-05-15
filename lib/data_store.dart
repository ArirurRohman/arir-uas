import 'package:flutter/material.dart';

class ServiceLog {
  final String title;
  final String subtitle;
  final String price;
  final IconData icon;
  final Color color;
  final bool showIndicator;
  final DateTime date;

  ServiceLog({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    this.color = Colors.red,
    this.showIndicator = false,
    required this.date,
  });
}

class DataStore {
  static final DataStore _instance = DataStore._internal();
  factory DataStore() => _instance;
  DataStore._internal();

  final ValueNotifier<List<ServiceLog>> servicesNotifier = ValueNotifier<List<ServiceLog>>([
    ServiceLog(
      title: 'Shell Helix Oil Change',
      subtitle: 'OCT 24, 2023 • MAINTENANCE',
      price: '\$185.00',
      icon: Icons.oil_barrel,
      date: DateTime(2023, 10, 24),
    ),
    ServiceLog(
      title: 'Brake Pad Replacement',
      subtitle: 'SEP 12, 2023 • REPAIR',
      price: '\$420.50',
      icon: Icons.album_outlined,
      showIndicator: true,
      date: DateTime(2023, 9, 12),
    ),
    ServiceLog(
      title: 'Wheel Alignment',
      subtitle: 'AUG 05, 2023 • MAINTENANCE',
      price: '\$120.00',
      icon: Icons.settings_input_component,
      date: DateTime(2023, 8, 5),
    ),
    ServiceLog(
      title: 'ECU Diagnostics',
      subtitle: 'JUL 18, 2023 • INSPECTION',
      price: '\$85.00',
      icon: Icons.analytics,
      date: DateTime(2023, 7, 18),
    ),
  ]);

  void addService(ServiceLog service) {
    servicesNotifier.value = [service, ...servicesNotifier.value];
  }
}
