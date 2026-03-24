import 'package:flutter/material.dart';

import '../../../../core/widgets/shared_bottom_bar.dart';

class ObstacleDetectionPage extends StatefulWidget {
  const ObstacleDetectionPage({super.key});

  @override
  State<ObstacleDetectionPage> createState() => _ObstacleDetectionPageState();
}

class _ObstacleDetectionPageState extends State<ObstacleDetectionPage> {
  bool isCameraOn = false;
  bool isSoundOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engelleri Tespit Et'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFEBEBEB)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height / 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kamera: ${isCameraOn ? 'Acik' : 'Kapali'}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: isCameraOn,
                    onChanged: (value) {
                      setState(() {
                        isCameraOn = value;
                      });
                    },
                    activeThumbColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sesli Bildirim: ${isSoundOn ? 'Acik' : 'Kapali'}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch(
                    value: isSoundOn,
                    onChanged: (value) {
                      setState(() {
                        isSoundOn = value;
                      });
                    },
                    activeThumbColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 1),
    );
  }
}
