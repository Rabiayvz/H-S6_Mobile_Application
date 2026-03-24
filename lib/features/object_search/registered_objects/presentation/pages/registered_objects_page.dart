import 'package:flutter/material.dart';

import '../../../../../core/widgets/shared_bottom_bar.dart';
import '../../data/models/registered_object.dart';
import '../../data/repositories/registered_objects_repository.dart';

class RegisteredObjectsPage extends StatefulWidget {
  const RegisteredObjectsPage({super.key});

  @override
  State<RegisteredObjectsPage> createState() => _RegisteredObjectsPageState();
}

class _RegisteredObjectsPageState extends State<RegisteredObjectsPage> {
  static const _repository = RegisteredObjectsRepository();
  late final Future<List<RegisteredObject>> _objectsFuture;

  @override
  void initState() {
    super.initState();
    _objectsFuture = _repository.getRegisteredObjects();
  }

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'aksesuar':
        return Icons.accessibility_new_rounded;
      case 'giyim':
        return Icons.checkroom_rounded;
      case 'kisisel':
        return Icons.person_outline_rounded;
      case 'elektronik':
        return Icons.devices_other_rounded;
      case 'saglik':
        return Icons.medical_services_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  Future<void> _simulateFindObject(RegisteredObject object) async {
    if (!mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
              SizedBox(width: 12),
              Expanded(child: Text('Kamera analizi suruyor...')),
            ],
          ),
        );
      },
    );

    await Future<void>.delayed(const Duration(milliseconds: 1300));
    if (!mounted) {
      return;
    }
    Navigator.of(context, rootNavigator: true).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${object.name} bulundu (onizleme modu).'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPreviewInfo() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Onizleme Akisi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text('1) Kullanici objenin fotografini ceker ve adini girer.'),
              SizedBox(height: 4),
              Text('2) Bu ekran o objeyi kart olarak listeler.'),
              SizedBox(height: 4),
              Text('3) Karta dokununca kamera taramasi baslar.'),
              SizedBox(height: 4),
              Text(
                '4) Deep learning entegrasyonu tamamlaninca, gercek tespit sonucu gosterilir.',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Kayitli Objelerim'),
        actions: [
          IconButton(
            onPressed: _showPreviewInfo,
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: 'Onizleme akis bilgisi',
          ),
        ],
      ),
      body: FutureBuilder<List<RegisteredObject>>(
        future: _objectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Objeler yuklenemedi.'));
          }

          final objects = snapshot.data ?? [];
          if (objects.isEmpty) {
            return const Center(child: Text('Kayitli obje bulunamadi.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: objects.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final item = objects[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _simulateFindObject(item),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFFEDEDED),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 36,
                                      color: Color(0xFF8D8D8D),
                                    ),
                                  );
                                },
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.55),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Text(
                                    'Onizleme',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _iconForCategory(item.category),
                                    color: const Color(0xFF5F5F5F),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      item.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.category,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showPreviewInfo,
        icon: const Icon(Icons.add_a_photo_outlined),
        label: const Text('Ekle (Onizleme)'),
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 2),
    );
  }
}
