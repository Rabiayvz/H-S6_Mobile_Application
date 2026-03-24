import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/widgets/shared_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final int battery = 55;

  IconData getBatteryIcon(int batteryLevel) {
    if (batteryLevel >= 70) {
      return Icons.battery_full;
    } else if (batteryLevel >= 30) {
      return Icons.battery_5_bar;
    } else {
      return Icons.battery_0_bar;
    }
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String content,
    String routeName,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 4),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEBEBEB)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Merhaba! Hoş geldiniz.',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D4D4D),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bugun size nasil yardimci olabiliriz?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              _buildFeatureCard(
                context,
                'Engelleri Tespit Et',
                '"Onumde engel var mi?" Bas hizasindaki engelleri algilayin ve bildirim alin.',
                AppRoutes.obstacleDetection,
              ),
              _buildFeatureCard(
                context,
                'Aradigin Nesneleri Bul',
                '"Yakinimda ne var?" Cevrenizdeki nesneleri algilayin ve konumlarini ogrenin.',
                AppRoutes.objectSearch,
              ),
              _buildFeatureCard(
                context,
                'Goruntulu Arama',
                'Aninda kamera paylas, destek iste.',
                AppRoutes.videoCall,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DeviceStatusCard(
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    icon: getBatteryIcon(battery),
                    label: 'Gozluk',
                  ),
                  const SizedBox(width: 16),
                  _DeviceStatusCard(
                    width: MediaQuery.of(context).size.width * 0.5 - 32,
                    icon: getBatteryIcon(battery),
                    label: 'RPI',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 0),
    );
  }
}

class _DeviceStatusCard extends StatelessWidget {
  const _DeviceStatusCard({
    required this.width,
    required this.icon,
    required this.label,
  });

  final double width;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
