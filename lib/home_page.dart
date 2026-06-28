import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'camera_page.dart';
import 'forecasting_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final bool isPetugas;
  const HomePage({super.key, required this.isPetugas});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(isPetugas: widget.isPetugas),
      const ForecastingPage(),
      // --- PERUBAHAN LOGIKA DINAMIS DI SINI ---
      widget.isPetugas ? const PocketBookContent() : const FarmerNewsContent(),
      ProfilePage(isPetugas: widget.isPetugas),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        height: 68,
        width: 68,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF2ECC71), Color(0xFF16A085)]),
          boxShadow: [BoxShadow(color: const Color(0xFF2ECC71).withOpacity(0.4), blurRadius: 12, spreadRadius: 2, offset: const Offset(0, 4))],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage(isPetugas: widget.isPetugas)),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.qr_code_scanner_rounded, size: 36, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 70,
            color: Colors.black.withOpacity(0.65),
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildNavItem(icon: Icons.home_rounded, label: 'Beranda', index: 0),
                    const SizedBox(width: 12),
                    _buildNavItem(icon: Icons.analytics_rounded, label: 'Peramalan', index: 1),
                  ],
                ),
                const SizedBox(width: 48),
                Row(
                  children: [
                    // --- IKON DAN TEKS NAVIGASI BERUBAH SESUAI ROLE ---
                    _buildNavItem(
                      icon: widget.isPetugas ? Icons.menu_book_rounded : Icons.newspaper_rounded, 
                      label: widget.isPetugas ? 'Buku Saku' : 'Berita', 
                      index: 2
                    ),
                    const SizedBox(width: 12),
                    _buildNavItem(icon: Icons.person_rounded, label: 'Profil', index: 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFF2ECC71) : Colors.white54, size: 24),
            const SizedBox(height: 4),
            Text(label, style: GoogleFonts.montserrat(fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? const Color(0xFF2ECC71) : Colors.white54)),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// WIDGET 1: BERANDA
// ============================================================================
class HomeContent extends StatelessWidget {
  final bool isPetugas;
  const HomeContent({super.key, required this.isPetugas});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1701665836468-4346c4d0d574?q=80&w=776&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800]),
        ),
        Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.9)]))),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isPetugas ? 'Halo, Petugas Koji 👋' : 'Halo, Koji 👋',
                          style: GoogleFonts.quicksand(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF2ECC71), size: 16),
                            const SizedBox(width: 4),
                            Text('Surabaya, Jawa Timur', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: isPetugas ? const Color(0xFF1E3A8A) : const Color(0xFF2ECC71),
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildGlassCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherInfo(Icons.thermostat, 'Suhu', '32°C'),
                      _buildWeatherInfo(Icons.water_drop, 'Kelembaban', '78%'),
                      _buildWeatherInfo(Icons.air, 'Angin', '12 km/j'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildGlassCard(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFF2ECC71).withOpacity(0.2), shape: BoxShape.circle),
                        child: const Icon(Icons.document_scanner_outlined, size: 48, color: Color(0xFF2ECC71)),
                      ),
                      const SizedBox(height: 16),
                      Text('Inspeksi Lapangan', style: GoogleFonts.quicksand(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      Text('Tekan tombol lingkaran hijau di tengah bawah layar untuk memulai sesi pemindaian daun padi.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70, height: 1.5)),
                    ],
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.white.withOpacity(0.15))),
          child: child,
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 28),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}

// ============================================================================
// WIDGET 2A: BUKU SAKU (KHUSUS ROLE PETUGAS)
// ============================================================================
class PocketBookContent extends StatelessWidget {
  const PocketBookContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Buku Saku POPT', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildDiseaseCard('Penyakit Blas', 'Pyricularia oryzae', 'Gejala: Bercak berbentuk belah ketupat pada daun.', Colors.orangeAccent),
          const SizedBox(height: 16),
          _buildDiseaseCard('Hawar Daun Bakteri (Kresek)', 'Xanthomonas oryzae', 'Gejala: Luka menguning dari ujung daun yang meluas ke bawah.', Colors.redAccent),
          const SizedBox(height: 16),
          _buildDiseaseCard('Tungro', 'Rice Tungro Bacilliform Virus', 'Gejala: Daun berwarna kuning-oranye dan tanaman kerdil.', Colors.yellowAccent),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildDiseaseCard(String title, String latin, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(latin, style: GoogleFonts.montserrat(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.white70)),
          const Divider(color: Colors.white24, height: 24),
          Text(desc, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white, height: 1.4)),
        ],
      ),
    );
  }
}

// ============================================================================
// WIDGET 2B: BERITA & PERINGATAN DINI (KHUSUS ROLE PETANI)
// ============================================================================
class FarmerNewsContent extends StatelessWidget {
  const FarmerNewsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Kabar & Peringatan Tani', style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildNewsCard(
            tag: 'DARURAT HAMA',
            tagColor: Colors.redAccent,
            date: '27 Juni 2026 • 05.30 WIB',
            title: 'PERINGATAN DINI: Potensi Ledakan Blas di Sidoarjo & Surabaya',
            content: 'Satelit mendeteksi kelembaban udara mencapai 88% dalam 48 jam terakhir. Segera lakukan pengeringan petak sawah secara berkala (intermittent).',
            imgUrl: 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?q=80&w=600&auto=format&fit=crop',
          ),
          const SizedBox(height: 18),
          _buildNewsCard(
            tag: 'INFO BANTUAN',
            tagColor: const Color(0xFF2ECC71),
            date: '25 Juni 2026',
            title: 'Subsidi Benih Tahan Wereng (Inpari 42) Telah Tiba',
            content: 'Alokasi benih bersubsidi gelombang II sudah dapat ditebus di Balai Penyuluhan Kecamatan masing-masing dengan membawa kartu Poktan.',
            imgUrl: 'https://images.unsplash.com/photo-1592982537447-7440770cbfc9?q=80&w=600&auto=format&fit=crop',
          ),
          const SizedBox(height: 18),
          _buildNewsCard(
            tag: 'EDUKASI',
            tagColor: Colors.orangeAccent,
            date: '21 Juni 2026',
            title: 'Tips PPL: Jangan menyemprot fungisida saat siang terik',
            content: 'Penyemprotan di atas jam 10.00 pagi membuat butiran obat menguap sebelum sempat diserap oleh stomata daun padi.',
            imgUrl: 'https://images.unsplash.com/photo-1625246333195-78d9c38ad449?q=80&w=600&auto=format&fit=crop',
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildNewsCard({required String tag, required Color tagColor, required String date, required String title, required String content, required String imgUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            child: Image.network(imgUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: tagColor.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                      child: Text(tag, style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, color: tagColor)),
                    ),
                    Text(date, style: GoogleFonts.montserrat(fontSize: 11, color: Colors.white54)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(title, style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 6),
                Text(content, style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}