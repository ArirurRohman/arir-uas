import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[900],
              child: const Icon(Icons.person, color: Colors.white, size: 20),
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
                  _buildTextField(_costController, '0', prefixText: 'Rp '),
                  const SizedBox(height: 20),
                  
                  _buildLabel('SERVICE NOTES'),
                  _buildTextField(_notesController, 'Detail parts used, technician notes, or future recommendations...', maxLines: 5),
                  
                  const SizedBox(height: 30),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
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
            _buildTemplateItem('Standard Oil Service'),
            _buildTemplateItem('Tire Rotation'),
            _buildTemplateItem('Brake Pad Replacement'),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(canvasColor: const Color(0xFF141414)),
        child: BottomNavigationBar(
          currentIndex: 1, // Service tab active
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

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, String? prefixText}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
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

  Widget _buildTemplateItem(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          ),
          const Icon(Icons.add_circle_outline, color: Colors.white60, size: 20),
        ],
      ),
    );
  }
}
