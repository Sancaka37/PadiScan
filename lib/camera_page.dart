import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';
import 'result_page.dart';

class CameraPage extends StatefulWidget {
  final bool isPetugas;
  const CameraPage({super.key, required this.isPetugas});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        final camera = _cameras!.firstWhere(
          (cam) => cam.lensDirection == CameraLensDirection.back,
          orElse: () => _cameras!.first,
        );

        _controller = CameraController(
          camera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      debugPrint("Error menyalakan kamera: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isCameraInitialized && _controller != null
              ? SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller!.value.previewSize?.height ?? 1,
                      height: _controller!.value.previewSize?.width ?? 1,
                      child: CameraPreview(_controller!),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator(color: Color(0xFF2ECC71))),
          
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.6), Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.8)],
                stops: const [0.0, 0.2, 0.75, 1.0],
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.circle, color: Color(0xFF1E3A8A), size: 14),
                          ),
                          const SizedBox(width: 8),
                          Text('PadiScan', style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            color: Colors.black.withOpacity(0.5),
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.montserrat(fontSize: 12, color: Colors.white70),
                                children: [
                                  const TextSpan(text: 'Rumpun '),
                                  TextSpan(text: '12/30', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: Stack(
                          children: [
                            _buildCorner(Alignment.topLeft, top: true, left: true),
                            _buildCorner(Alignment.topRight, top: true, left: false),
                            _buildCorner(Alignment.bottomLeft, top: false, left: true),
                            _buildCorner(Alignment.bottomRight, top: false, left: false),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white24)),
                            child: Text('Posisikan rumpun padi di\ndalam bingkai', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka galeri foto...')));
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(color: const Color(0xFF3B4A3F), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white, width: 1.5)),
                              child: const Icon(Icons.image_outlined, color: Colors.white, size: 26),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ResultPage(isPetugas: widget.isPetugas)),
                            );
                          },
                          child: Container(
                            width: 76,
                            height: 76,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3.5)),
                            child: Container(decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment, {required bool top, required bool left}) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            top: top ? const BorderSide(color: Colors.white, width: 3.5) : BorderSide.none,
            bottom: !top ? const BorderSide(color: Colors.white, width: 3.5) : BorderSide.none,
            left: left ? const BorderSide(color: Colors.white, width: 3.5) : BorderSide.none,
            right: !left ? const BorderSide(color: Colors.white, width: 3.5) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}