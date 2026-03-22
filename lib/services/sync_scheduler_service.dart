import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import '../models/sync_config.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $task");
    print("Fetching sensor data via Bluetooth...");

    // Simulate some work
    await Future.delayed(const Duration(seconds: 2));

    print("Data synced successfully");
    return Future.value(true);
  });
}

class SyncSchedulerService {
  static const String syncTaskKey = "com.diasole.syncTask";
  static const String configStorageKey = "syncConfig";

  static Future<void> init() async {
    if (kIsWeb) return;
    await Workmanager().initialize(callbackDispatcher);
  }

  static Future<void> scheduleSync(SyncConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(configStorageKey, jsonEncode(config.toJson()));

    if (kIsWeb) return;

    await Workmanager().cancelByUniqueName(syncTaskKey);

    Duration frequency;
    switch (config.type) {
      case SyncType.daily:
        frequency = const Duration(days: 1);
        break;
      case SyncType.weekly:
        frequency = const Duration(days: 7);
        break;
      case SyncType.monthly:
        frequency = const Duration(days: 30);
        break;
    }

    // Register a periodic task
    await Workmanager().registerPeriodicTask(
      syncTaskKey,
      "syncTaskName",
      frequency: frequency,
    );
  }

  static Future<SyncConfig?> getSavedConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(configStorageKey);
    if (data != null) {
      return SyncConfig.fromJson(jsonDecode(data));
    }
    return null;
  }
}
