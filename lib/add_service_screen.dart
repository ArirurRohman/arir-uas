import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'placeholder_screens.dart';
import 'data_store.dart';
import 'package:intl/intl.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  int _currentIndex = 1;

  void _saveLog() {
    if (_nameController.text.isEmpty) {
      _showError('Please enter a service name.');
      return;
    }
    if (_selectedDate == null) {
      _showError('Please select a service date.');
      return;
    }

    // Save to DataStore
    final newLog = ServiceLog(
      title: _nameController.text,
      subtitle: '${DateFormat('MMM dd, yyyy').format(_selectedDate!).toUpperCase()} • MAINTENANCE',
      price: 'Rp ${_costController.text}',
      icon: Icons.build,
      date: _selectedDate!,
    );
    
    DataStore().addService(newLog);

    // Success Simulation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Service log saved successfully!',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.pop(context);
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _applyTemplate(String name, String cost) {
    setState(() {
      _nameController.text = name;
      _costController.text = cost;
      _selectedDate = DateTime.now();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blueGrey[800],
        content: Text('Template "$name" applied.', style: GoogleFonts.inter()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[900],
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.build_circle_outlined, color: Colors.white60, size: 18),
                const SizedBox(width: 8),
                Text(
                  'SERVICE CENTER',
                  style: GoogleFonts.inter(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Add Service Log',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Document your vehicle's maintenance with technical precision.",
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),

            // Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('SERVICE NAME'),
                  _buildTextField(_nameController, 'e.g., Oil Change / Brake Flush'),
                  const SizedBox(height: 20),
                  
                  _buildLabel('SERVICE DATE'),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  
                  _buildLabel('COST (IDR)'),
                  _buildTextField(_costController, '0', prefixText: 'Rp ', keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  
                  _buildLabel('SERVICE NOTES'),
                  _buildTextField(_notesController, 'Detail parts used, technician notes, or future recommendations...', maxLines: 5),
                  
                  const SizedBox(height: 30),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _saveLog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        'SAVE LOG',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Technical Insight Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Colors.red, size: 24),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Technical Insight',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Maintaining a digital log increases your vehicle's resale value and ensures engineering longevity.",
                          style: GoogleFonts.inter(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Templates Section
            Text(
              'QUICK TEMPLATES',
              style: GoogleFonts.inter(
                color: Colors.white60,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 15),
            _buildTemplateItem('Standard Oil Service', () => _applyTemplate('Standard Oil Service', '450000')),
            _buildTemplateItem('Tire Rotation', () => _applyTemplate('Tire Rotation', '150000')),
            _buildTemplateItem('Brake Pad Replacement', () => _applyTemplate('Brake Pad Replacement', '1200000')),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: const Color(0xFF141414)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == _currentIndex) return;
            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              Navigator.pop(context); // Go back to Garage
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white60,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, String? prefixText, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 14),
        prefixText: prefixText,
        prefixStyle: GoogleFonts.inter(color: Colors.white),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  surface: Color(0xFF1A1A1A),
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: const Color(0xFF0D0D0D),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null ? 'mm/dd/yyyy' : "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}",
              style: GoogleFonts.inter(
                color: _selectedDate == null ? Colors.white24 : Colors.white,
                fontSize: 14,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.white24, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateItem(String text, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        onTap: onTap,
        title: Text(
          text,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
        ),
        trailing: const Icon(Icons.add_circle_outline, color: Colors.white60, size: 20),
      ),
    );
  }
}
