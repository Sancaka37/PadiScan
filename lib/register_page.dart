import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Variabel untuk melacak peran yang dipilih (default: false = Petani)
  bool isPetugas = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Latar Belakang (Sama dengan Halaman Login)
          Image.network(
            'https://images.unsplash.com/photo-1590682680695-43b964a3ae17?q=80&w=1000&auto=format&fit=crop',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800]),
          ),
          
          // 2. Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.9)],
              ),
            ),
          ),

          // 3. Form Pendaftaran Glassmorphism
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(24.0),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Akun',
                          style: GoogleFonts.quicksand(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pilih peran Anda untuk menyesuaikan pengalaman menggunakan PadiScan.',
                          style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white70, height: 1.5),
                        ),
                        const SizedBox(height: 24),

                        // --- TAB PILIHAN PERAN (PETANI / PETUGAS) ---
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => isPetugas = false),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: !isPetugas ? const Color(0xFF2ECC71) : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Petani',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: !isPetugas ? Colors.white : Colors.white54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => isPetugas = true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isPetugas ? const Color(0xFF1E3A8A) : Colors.transparent, // Biru elegan untuk Petugas
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Petugas POPT',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: isPetugas ? Colors.white : Colors.white54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- INPUT FORM ---
                        _buildTextField(hint: 'Nama Lengkap', icon: Icons.person),
                        const SizedBox(height: 16),
                        _buildTextField(hint: 'Nomor WhatsApp', icon: Icons.phone, isNumber: true),
                        
                        // Memunculkan kolom NIP secara dinamis jika "Petugas" dipilih
                        if (isPetugas) ...[
                          const SizedBox(height: 16),
                          _buildTextField(hint: 'Nomor Pegawai (NIP)', icon: Icons.badge, isNumber: true),
                        ],
                        const SizedBox(height: 32),
                        
                        // --- TOMBOL DAFTAR ---
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Mendaftar sebagai ${isPetugas ? "Petugas POPT" : "Petani"}...')),
                              );
                              Navigator.pop(context); // Kembali ke halaman login setelah daftar
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPetugas ? const Color(0xFF1E3A8A) : const Color(0xFF2ECC71),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                            ),
                            child: Text(
                              'Daftar Sekarang',
                              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu untuk Form Input
  Widget _buildTextField({required String hint, required IconData icon, bool isNumber = false}) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0), borderSide: BorderSide.none),
      ),
    );
  }
}