import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../core/widgets/shared_bottom_bar.dart';
import '../../data/models/search_target.dart';
import '../../data/repositories/search_targets_repository.dart';

class GeneralObjectSearchPage extends StatefulWidget {
  const GeneralObjectSearchPage({super.key});

  @override
  State<GeneralObjectSearchPage> createState() =>
      _GeneralObjectSearchPageState();
}

class _GeneralObjectSearchPageState extends State<GeneralObjectSearchPage> {
  static const _repository = SearchTargetsRepository();

  late final Future<List<SearchTarget>> _targetsFuture;
  final Random _random = Random();

  SearchTarget? _selectedTarget;
  bool _isScanning = false;
  bool _isFound = false;
  String _statusText = 'Tarama baslatilmadi.';
  Timer? _scanTimer;
  int _ticks = 0;

  @override
  void initState() {
    super.initState();
    _targetsFuture = _repository.getTargets();
  }

  IconData _iconFromName(String iconName) {
    switch (iconName) {
      case 'delete_outline':
        return Icons.delete_outline;
      case 'door_front_door_outlined':
        return Icons.door_front_door_outlined;
      case 'stairs_outlined':
        return Icons.stairs_outlined;
      case 'chair_outlined':
        return Icons.chair_outlined;
      case 'table_restaurant_outlined':
        return Icons.table_restaurant_outlined;
      default:
        return Icons.search;
    }
  }

  void _selectTarget(SearchTarget target) {
    setState(() {
      _selectedTarget = target;
      _isFound = false;
      _statusText = '${target.label} secildi. Taramayi baslatabilirsiniz.';
    });
  }

  void _toggleScan() {
    if (_selectedTarget == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lutfen once aranacak objeyi secin.')),
      );
      return;
    }

    if (_isScanning) {
      _stopScan();
      return;
    }

    setState(() {
      _isScanning = true;
      _isFound = false;
      _ticks = 0;
      _statusText = '${_selectedTarget!.label} araniyor...';
    });

    _scanTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        return;
      }

      _ticks += 1;
      final shouldFind = _ticks >= 3 && _random.nextDouble() > 0.45;

      if (shouldFind) {
        setState(() {
          _isFound = true;
          _isScanning = false;
          _statusText = '${_selectedTarget!.label} bulundu (onizleme).';
        });
        timer.cancel();
        return;
      }

      setState(() {
        _statusText = '${_selectedTarget!.label} araniyor...';
      });
    });
  }

  void _stopScan() {
    _scanTimer?.cancel();
    setState(() {
      _isScanning = false;
      _statusText = 'Tarama durduruldu.';
    });
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Genel Obje Arama'),
      ),
      body: FutureBuilder<List<SearchTarget>>(
        future: _targetsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Hedefler yuklenemedi.'));
          }

          final targets = snapshot.data ?? [];
          if (targets.isNotEmpty && _selectedTarget == null) {
            _selectedTarget = targets.first;
            _statusText =
                '${_selectedTarget!.label} secildi. Taramayi baslatabilirsiniz.';
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2E2E2E), Color(0xFF111111)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 16,
                        top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.38),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            'Kamera Onizleme',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (_selectedTarget != null)
                        Center(
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    _isFound
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFF90CAF9),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _iconFromName(_selectedTarget!.iconName),
                                  color: Colors.white,
                                  size: 46,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _selectedTarget!.label,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aranacak Obje',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      targets.map((target) {
                        final isSelected = _selectedTarget?.id == target.id;
                        return ChoiceChip(
                          selected: isSelected,
                          onSelected: (_) => _selectTarget(target),
                          avatar: Icon(
                            _iconFromName(target.iconName),
                            size: 18,
                          ),
                          label: Text(target.label),
                        );
                      }).toList(),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        _isFound
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusText,
                    style: TextStyle(
                      color:
                          _isFound
                              ? const Color(0xFF1B5E20)
                              : const Color(0xFF424242),
                      fontWeight: _isFound ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _toggleScan,
                    icon: Icon(
                      _isScanning
                          ? Icons.stop_circle_outlined
                          : Icons.play_arrow_rounded,
                    ),
                    label: Text(
                      _isScanning ? 'Taramayi Durdur' : 'Taramayi Baslat',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 2),
    );
  }
}
