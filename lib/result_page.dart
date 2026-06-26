import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'camera_page.dart'; // <--- Import ini sangat penting agar bisa kembali ke kamera

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

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
        title: Text(
          'Hasil Analisis AI',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Latar Belakang Fotografi
          Image.network(
            'https://images.unsplash.com/photo-1590682680695-43b964a3ae17?q=80&w=1000&auto=format&fit=crop',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: Colors.grey[800]);
            },
          ),
          
          // 2. Dark Overlay Lebih Pekat
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.95), // Sangat gelap di bawah agar teks mudah dibaca
                ],
              ),
            ),
          ),

          // 3. Konten Utama
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- AREA GAMBAR HASIL SCAN ---
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // Foto ilustrasi daun padi yang terkena penyakit
                          Image.network(
                            'https://images.unsplash.com/photo-1530836369250-ef71a3f5e48c?q=80&w=1000&auto=format&fit=crop',
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          // Indikator Grad-CAM di pojok gambar
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF2ECC71)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.center_focus_strong, color: Color(0xFF2ECC71), size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Grad-CAM Aktif',
                                    style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- JUDUL PENYAKIT ---
                  Text(
                    'Penyakit Blas',
                    style: GoogleFonts.quicksand(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Pyricularia oryzae',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- KARTU METRIK MODEL ---
                  Row(
                    children: [
                      Expanded(
                        child: _buildGlassMetric(
                          icon: Icons.analytics,
                          label: 'Akurasi ResNet34',
                          value: '97.90%', // Sesuai hasil uji modelmu
                          valueColor: const Color(0xFF2ECC71),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildGlassMetric(
                          icon: Icons.warning_amber_rounded,
                          label: 'Tingkat Keparahan',
                          value: 'Sedang',
                          valueColor: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- KARTU MITIGASI ---
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.medical_information, color: Color(0xFF2ECC71)),
                            const SizedBox(width: 8),
                            Text(
                              'Rekomendasi Tindakan',
                              style: GoogleFonts.quicksand(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white24, height: 24),
                        _buildListTile('Kurangi penggunaan pupuk Nitrogen (Urea) secara berlebihan pada petak ini.'),
                        _buildListTile('Segera aplikasikan fungisida berbahan aktif trisiklazol sesuai dosis anjuran PPL.'),
                        _buildListTile('Keringkan petakan sawah secara berkala (intermittent irrigation) untuk menekan kelembaban.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- TOMBOL AKSI ---
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi agregasi ke data BBPOPT
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Data 30-rumpun berhasil disimpan.')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2ECC71),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      ),
                      child: Text(
                        'Simpan ke Data BBPOPT',
                        style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // --- TOMBOL PINDAI LAGI YANG SUDAH DIPERBAIKI ---
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const CameraPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54, width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                      ),
                      child: Text(
                        'Pindai Daun Lainnya',
                        style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu: Kartu Kaca Transparan
  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: child,
        ),
      ),
    );
  }

  // Widget Pembantu: Kotak Metrik Akurasi & Keparahan
  Widget _buildGlassMetric({required IconData icon, required String label, required String value, required Color valueColor}) {
    return _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  // Widget Pembantu: Daftar Poin Rekomendasi
  Widget _buildListTile(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF2ECC71), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white70, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}