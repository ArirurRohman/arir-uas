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
    final lang = DataStore().languageNotifier.value;
    if (_nameController.text.isEmpty) {
      _showError(Localization.translate(lang, 'enter_name_error'));
      return;
    }
    if (_selectedDate == null) {
      _showError(Localization.translate(lang, 'select_date_error'));
      return;
    }

    // Save to DataStore
    final double cost = double.tryParse(_costController.text) ?? 0;
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    
    final newLog = ServiceLog(
      title: _nameController.text,
      subtitle: '${DateFormat('MMM dd, yyyy').format(_selectedDate!).toUpperCase()} • ${lang == 'Bahasa Indonesia' ? 'PEMELIHARAAN' : 'MAINTENANCE'}',
      price: formatter.format(cost),
      costValue: cost,
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
              Localization.translate(lang, 'toast_save'),
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

  void _applyTemplate(String name, String cost, String notes) {
    final lang = DataStore().languageNotifier.value;
    setState(() {
      _nameController.text = name;
      _costController.text = cost;
      _notesController.text = notes;
      _selectedDate = DateTime.now();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blueGrey[800],
        content: Text(Localization.translate(lang, 'template_applied', name), style: GoogleFonts.inter()),
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
                      Localization.translate(lang, 'service_center'),
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
                  Localization.translate(lang, 'add_service_log'),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Localization.translate(lang, 'document_precise'),
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
                      _buildLabel(Localization.translate(lang, 'service_name')),
                      _buildTextField(_nameController, lang == 'Bahasa Indonesia' ? 'misal, Ganti Oli / Minyak Rem' : 'e.g., Oil Change / Brake Flush'),
                      const SizedBox(height: 20),
                      
                      _buildLabel(Localization.translate(lang, 'service_date')),
                      _buildDatePicker(),
                      const SizedBox(height: 20),
                      
                      _buildLabel(Localization.translate(lang, 'cost_idr')),
                      _buildTextField(_costController, '0', prefixText: 'Rp ', keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      
                      _buildLabel(Localization.translate(lang, 'service_notes')),
                      _buildTextField(_notesController, lang == 'Bahasa Indonesia' ? 'Detail suku cadang, catatan teknisi, rekomendasi...' : 'Detail parts used, technician notes, or future recommendations...', maxLines: 5),
                      
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
                            Localization.translate(lang, 'save_log'),
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
                              Localization.translate(lang, 'technical_insight'),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              Localization.translate(lang, 'resale_value'),
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
                  Localization.translate(lang, 'quick_templates'),
                  style: GoogleFonts.inter(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 15),
                 _buildTemplateItem(
                  lang == 'Bahasa Indonesia' ? 'Servis Oli Standar' : 'Standard Oil Service', 
                  () => _applyTemplate(
                    lang == 'Bahasa Indonesia' ? 'Servis Oli Standar' : 'Standard Oil Service', 
                    '450000',
                    lang == 'Bahasa Indonesia' 
                      ? 'Penggantian oli mesin sintetis standar, filter oli premium, pemeriksaan level cairan, dan inspeksi umum.' 
                      : 'Standard synthetic engine oil change, premium oil filter replacement, fluid levels check, and multi-point inspection.'
                  )
                ),
                _buildTemplateItem(
                  lang == 'Bahasa Indonesia' ? 'Rotasi Ban' : 'Tire Rotation', 
                  () => _applyTemplate(
                    lang == 'Bahasa Indonesia' ? 'Rotasi Ban' : 'Tire Rotation', 
                    '150000',
                    lang == 'Bahasa Indonesia'
                      ? 'Rotasi silang keempat ban, inspeksi keausan tapak ban, penyesuaian tekanan angin, dan pemeriksaan balancing roda.'
                      : 'Cross-rotation of all four tires, inspection of tire tread wear, pressure adjustment, and wheel balancing check.'
                  )
                ),
                _buildTemplateItem(
                  lang == 'Bahasa Indonesia' ? 'Ganti Kampas Rem' : 'Brake Pad Replacement', 
                  () => _applyTemplate(
                    lang == 'Bahasa Indonesia' ? 'Ganti Kampas Rem' : 'Brake Pad Replacement', 
                    '1200000',
                    lang == 'Bahasa Indonesia'
                      ? 'Pemasangan kampas rem keramik premium, inspeksi dan pembersihan piringan cakram, pelumasan kaliper rem, dan pemeriksaan minyak rem.'
                      : 'Installation of premium ceramic brake pads, brake rotor inspection and cleaning, brake caliper lubrication, and fluid level check.'
                  )
                ),
                
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
