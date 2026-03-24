import 'package:flutter/material.dart';

import '../../../../core/widgets/shared_bottom_bar.dart';
import '../../general_search/presentation/pages/general_object_search_page.dart';
import '../../registered_objects/presentation/pages/registered_objects_page.dart';

class ObjectSearchPage extends StatelessWidget {
  const ObjectSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Obje Arama'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ObjectSearchCard(
                title: 'Kayit Obje Ekleme',
                description:
                    'Bulmakta zorlanilan esyalari bulmayi kolaylastirma',
                iconData: Icons.create_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisteredObjectsPage(),
                    ),
                  );
                },
              ),
              _ObjectSearchCard(
                title: 'Genel Obje Arama',
                description: 'Istenilen objeyi cevre icinde arama',
                iconData: Icons.find_in_page_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GeneralObjectSearchPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 2),
    );
  }
}

class _ObjectSearchCard extends StatelessWidget {
  const _ObjectSearchCard({
    required this.title,
    required this.description,
    required this.iconData,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.25,
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
              Icon(
                iconData,
                size: 48,
                color: const Color.fromARGB(255, 160, 160, 160),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
