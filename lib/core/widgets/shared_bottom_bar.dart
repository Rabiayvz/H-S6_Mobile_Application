import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SharedBottomBar extends StatefulWidget {
  const SharedBottomBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  State<SharedBottomBar> createState() => _SharedBottomBarState();
}

class _SharedBottomBarState extends State<SharedBottomBar> {
  static const Color _iconColor = Color(0xFF8A8A8A);

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _wifiSubscription;
  StreamSubscription<BluetoothAdapterState>? _bluetoothAdapterSubscription;
  StreamSubscription<OnConnectionStateChangedEvent>?
  _bluetoothConnectionSubscription;

  bool _isWifiConnected = false;
  bool _isBluetoothAdapterOn = false;
  bool _isBluetoothConnected = false;

  @override
  void initState() {
    super.initState();
    _safeInitConnectivityWatchers();
    _safeInitBluetoothWatchers();
  }

  Future<void> _safeInitConnectivityWatchers() async {
    try {
      await _initConnectivityWatchers();
    } on MissingPluginException {
      _setWifiConnected(false);
    } on UnsupportedError {
      _setWifiConnected(false);
    } catch (_) {
      _setWifiConnected(false);
    }
  }

  Future<void> _initConnectivityWatchers() async {
    final current = await _connectivity.checkConnectivity();
    if (!mounted) {
      return;
    }
    _updateWifiState(current);

    _wifiSubscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        _updateWifiState(results);
      },
      onError: (_) {
        _setWifiConnected(false);
      },
    );
  }

  void _updateWifiState(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (result) =>
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn ||
          result == ConnectivityResult.other,
    );

    _setWifiConnected(isConnected);
  }

  void _setWifiConnected(bool value) {
    if (!mounted) {
      return;
    }
    setState(() {
      _isWifiConnected = value;
    });
  }

  void _safeInitBluetoothWatchers() {
    if (kIsWeb) {
      _setBluetoothStatus(adapterOn: false, connected: false);
      return;
    }

    try {
      _initBluetoothWatchers();
    } on UnsupportedError {
      _setBluetoothStatus(adapterOn: false, connected: false);
    } catch (_) {
      _setBluetoothStatus(adapterOn: false, connected: false);
    }
  }

  void _initBluetoothWatchers() {
    _bluetoothAdapterSubscription = FlutterBluePlus.adapterState.listen(
      (state) {
        final isOn = state == BluetoothAdapterState.on;
        _setBluetoothStatus(adapterOn: isOn, connected: _isBluetoothConnected);
        _refreshBluetoothConnectionState();
      },
      onError: (_) {
        _setBluetoothStatus(adapterOn: false, connected: false);
      },
    );

    _bluetoothConnectionSubscription = FlutterBluePlus
        .events
        .onConnectionStateChanged
        .listen(
          (_) {
            _refreshBluetoothConnectionState();
          },
          onError: (_) {
            _setBluetoothStatus(adapterOn: false, connected: false);
          },
        );

    _refreshBluetoothConnectionState();
  }

  void _refreshBluetoothConnectionState() {
    try {
      final hasConnectedDevice = FlutterBluePlus.connectedDevices.isNotEmpty;
      _setBluetoothStatus(
        adapterOn: _isBluetoothAdapterOn,
        connected: _isBluetoothAdapterOn && hasConnectedDevice,
      );
    } on UnsupportedError {
      _setBluetoothStatus(adapterOn: false, connected: false);
    } catch (_) {
      _setBluetoothStatus(adapterOn: false, connected: false);
    }
  }

  void _setBluetoothStatus({required bool adapterOn, required bool connected}) {
    if (!mounted) {
      return;
    }
    setState(() {
      _isBluetoothAdapterOn = adapterOn;
      _isBluetoothConnected = connected;
    });
  }

  @override
  void dispose() {
    _wifiSubscription?.cancel();
    _bluetoothAdapterSubscription?.cancel();
    _bluetoothConnectionSubscription?.cancel();
    super.dispose();
  }

  void _onTap(int index) {
    if (index == 0 || index == 3) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothIcon =
        _isBluetoothConnected
            ? Icons.bluetooth_connected_rounded
            : Icons.bluetooth_disabled_rounded;

    final wifiIcon =
        _isWifiConnected ? Icons.wifi_rounded : Icons.wifi_off_rounded;

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: _iconColor,
      unselectedItemColor: _iconColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.info_outline_rounded),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(icon: Icon(bluetoothIcon), label: 'Bluetooth'),
        BottomNavigationBarItem(icon: Icon(wifiIcon), label: 'WiFi'),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings_outlined),
          label: 'Ayarlar',
        ),
      ],
    );
  }
}
