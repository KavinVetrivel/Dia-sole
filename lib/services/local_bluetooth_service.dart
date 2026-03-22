import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class AppBluetoothService {
  static Future<bool> isBluetoothOn() async {
    // Check if Bluetooth is supported
    if (await FlutterBluePlus.isSupported == false) {
      return false;
    }

    // Check Bluetooth state
    final state = await FlutterBluePlus.adapterState.first;
    return state == BluetoothAdapterState.on;
  }
}
