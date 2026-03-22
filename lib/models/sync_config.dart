import 'package:flutter/material.dart';

enum SyncType { daily, weekly, monthly }

class SyncConfig {
  SyncType type;
  String? day;
  int? date;
  TimeOfDay time;

  SyncConfig({
    required this.type,
    this.day,
    this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'day': day,
      'date': date,
      'time': '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
    };
  }

  factory SyncConfig.fromJson(Map<String, dynamic> json) {
    final timeParts = json['time'].split(':');
    return SyncConfig(
      type: SyncType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SyncType.daily,
      ),
      day: json['day'],
      date: json['date'],
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
    );
  }
}