import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  // Variabel penangkap data role
  final bool isPetugas;
  const ProfilePage({super.key, required this.isPetugas});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _toggleSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1590682680695-43b964a3ae17?q=80&w=1000&auto=format&fit=crop',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800]),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.9)],
            ),
          ),
        ),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Profil Akun', style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 32),

                // --- FOTO & IDENTITAS DINAMIS ---
                CircleAvatar(
                  radius: 50,
                  backgroundColor: widget.isPetugas ? const Color(0xFF1E3A8A) : const Color(0xFF2ECC71),
                  child: const Icon(Icons.person, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 16),
                Text('Koji', style: GoogleFonts.quicksand(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  widget.isPetugas ? 'Petugas POPT Wilayah III' : 'Petani - Poktan Sido Makmur',
                  style: GoogleFonts.montserrat(fontSize: 14, color: widget.isPetugas ? const Color(0xFF60A5FA) : const Color(0xFF2ECC71), fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.isPetugas ? 'NIP: 200504082026041001' : 'No. HP: 081234567890', 
                  style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white54),
                ),
                const SizedBox(height: 32),

                // --- KARTU STATISTIK DINAMIS ---
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        widget.isPetugas ? 'Total Sensus' : 'Riwayat Pindai', 
                        widget.isPetugas ? '124' : '12x', 
                        widget.isPetugas ? Icons.assignment_turned_in : Icons.document_scanner
                      )
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        widget.isPetugas ? 'Akurasi AI' : 'Luas Lahan', 
                        widget.isPetugas ? '97%' : '1.5 Ha', 
                        widget.isPetugas ? Icons.analytics : Icons.landscape
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- KARTU PENGATURAN DINAMIS ---
                _buildGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pengaturan Sistem', style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Divider(color: Colors.white24, height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.isPetugas ? 'Mode Luring (Offline)' : 'Notifikasi Peringatan Cuaca', 
                                  style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.isPetugas 
                                    ? 'Gunakan model AI ringan saat tidak ada sinyal internet.' 
                                    : 'Terima SMS jika cuaca buruk memicu penyakit.', 
                                  style: GoogleFonts.montserrat(fontSize: 11, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _toggleSwitch,
                            activeColor: widget.isPetugas ? const Color(0xFF60A5FA) : const Color(0xFF2ECC71),
                            onChanged: (value) => setState(() => _toggleSwitch = value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(widget.isPetugas ? Icons.sync : Icons.support_agent, color: widget.isPetugas ? const Color(0xFF60A5FA) : const Color(0xFF2ECC71)),
                          label: Text(
                            widget.isPetugas ? 'Sinkronisasi Data (3 Tertunda)' : 'Hubungi Penyuluh (PPL)',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: widget.isPetugas ? const Color(0xFF60A5FA) : const Color(0xFF2ECC71)),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: widget.isPetugas ? const Color(0xFF60A5FA) : const Color(0xFF2ECC71)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- TOMBOL KELUAR ---
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.2), 
                      foregroundColor: Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Colors.redAccent)),
                    ),
                    child: Text('Keluar Akun', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.white.withOpacity(0.15))),
          child: child,
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return _buildGlassCard(
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(title, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11, color: Colors.white54)),
        ],
      ),
    );
  }
}