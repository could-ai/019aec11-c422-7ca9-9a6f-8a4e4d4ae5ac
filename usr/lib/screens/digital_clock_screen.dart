import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalClockScreen extends StatefulWidget {
  const DigitalClockScreen({super.key});

  @override
  State<DigitalClockScreen> createState() => _DigitalClockScreenState();
}

class _DigitalClockScreenState extends State<DigitalClockScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  
  // Mock weather data
  String _temperature = "--";
  String _location = "Cargando...";
  String _weatherIcon = "☁️";

  @override
  void initState() {
    super.initState();
    _startClock();
    _fetchWeatherData(); // Simulating weather fetch
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  // Simulates fetching weather data
  Future<void> _fetchWeatherData() async {
    // In a real app, you would use Geolocator to get position
    // and an API like OpenWeatherMap to get temperature.
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _temperature = "24°C";
        _location = "Madrid, ES";
        _weatherIcon = "☀️";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formatters
    final timeFormat = DateFormat('HH:mm:ss');
    final dateFormat = DateFormat('EEEE, d MMMM yyyy');

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A), // Dark background
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Location and Weather Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.cyan.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _weatherIcon,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _temperature,
                          style: GoogleFonts.orbitron(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                            shadows: [
                              const Shadow(
                                blurRadius: 10.0,
                                color: Colors.cyan,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _location,
                          style: GoogleFonts.exo2(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 50),

              // Digital Clock Display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.cyanAccent.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      timeFormat.format(_currentTime),
                      style: GoogleFonts.orbitron(
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                        color: Colors.cyanAccent,
                        letterSpacing: 4,
                        shadows: [
                          const Shadow(
                            blurRadius: 20.0,
                            color: Colors.cyan,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dateFormat.format(_currentTime).toUpperCase(),
                      style: GoogleFonts.orbitron(
                        fontSize: 16,
                        color: Colors.cyanAccent.withOpacity(0.7),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Decorative elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatusIndicator("SYNC", true),
                  const SizedBox(width: 20),
                  _buildStatusIndicator("ALARM", false),
                  const SizedBox(width: 20),
                  _buildStatusIndicator("WIFI", true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.greenAccent : Colors.redAccent.withOpacity(0.3),
            boxShadow: isActive
                ? [
                    const BoxShadow(
                      color: Colors.greenAccent,
                      blurRadius: 5,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
