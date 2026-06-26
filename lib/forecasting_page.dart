import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForecastingPage extends StatelessWidget {
  const ForecastingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Analitik Prediktif',
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, 
      ),
      body: Stack(
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
                colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.95)],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proyeksi LightGBM',
                    style: GoogleFonts.quicksand(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prakiraan ancaman hama 30 hari ke depan berdasarkan data historis dan satelit.',
                    style: GoogleFonts.montserrat(fontSize: 13, color: Colors.white70, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status Kerawanan Wilayah', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white70)),
                            const Icon(Icons.warning_amber_rounded, color: Colors.orangeAccent),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text('WASPADA (Tingkat II)', style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.65,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(4),
                          minHeight: 8,
                        ),
                        const SizedBox(height: 8),
                        Text('Probabilitas serangan penyakit Blas meningkat hingga 65%.', style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white54)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('Faktor Pemicu Utama', style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),
                  _buildGlassCard(
                    child: Column(
                      children: [
                        _buildFactorRow('Kelembaban Udara (NASA)', '+24%', Colors.redAccent, Icons.water_drop),
                        const Divider(color: Colors.white24, height: 24),
                        _buildFactorRow('Suhu Rata-rata Harian', '+15%', Colors.redAccent, Icons.thermostat),
                        const Divider(color: Colors.white24, height: 24),
                        _buildFactorRow('Kecepatan Angin', '-5%', const Color(0xFF2ECC71), Icons.air),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildGlassCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: const Color(0xFF1E3A8A).withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.shield_outlined, color: Color(0xFF60A5FA), size: 32),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tindakan Preventif', style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                              const SizedBox(height: 6),
                              Text('Perketat jadwal pemantauan 30-rumpun pada fase anakan maksimal. Siapkan stok fungisida sistemik.', style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70, height: 1.5)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildFactorRow(String label, String impact, Color impactColor, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: impactColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
          child: Text(impact, style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold, color: impactColor)),
        ),
      ],
    );
  }
}