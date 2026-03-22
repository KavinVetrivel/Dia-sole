import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothService {
  static Future<bool> isBluetoothOn() async {
    if (kIsWeb) {
      // Bluetooth operations are generally not well supported natively in the same way on Web
      return true; // For web testing, assume it's on or handle gracefully
    }
    // Check if Bluetooth is supported
    if (await FlutterBluePlus.isSupported == false) {
      return false;
    }

    // Check Bluetooth state
    final state = await FlutterBluePlus.adapterState.first;
    return state == BluetoothAdapterState.on;
  }
}
