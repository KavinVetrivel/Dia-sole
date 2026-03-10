import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      _NotificationItem(
        title: "High Pressure Alert",
        description: "Detected unusual pressure on right heel during your run.",
        time: "10 min ago",
        type: _NotificationType.alert,
      ),
      _NotificationItem(
        title: "Daily Goal Achieved",
        description: "You reached 10,000 steps! Keep it up.",
        time: "2 hours ago",
        type: _NotificationType.success,
      ),
      _NotificationItem(
        title: "Battery Low",
        description:
            "Your smart insole battery is below 15%. Pulse charge recommended.",
        time: "Yesterday",
        type: _NotificationType.warning,
      ),
      _NotificationItem(
        title: "Weekly Report Ready",
        description: "Your gait analysis report for the week is ready to view.",
        time: "2 days ago",
        type: _NotificationType.info,
      ),
      _NotificationItem(
        title: "New Badge Earned",
        description: "Marathoner: You walked 42km this month!",
        time: "3 days ago",
        type: _NotificationType.success,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notifications",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Updates on your foot health.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final n = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.softShadow,
                        border: Border(
                          left: BorderSide(color: n.getColor(), width: 4),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(n.getIcon(), color: n.getColor(), size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  n.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  n.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  n.time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }
}

enum _NotificationType { alert, success, warning, info }

class _NotificationItem {
  final String title;
  final String description;
  final String time;
  final _NotificationType type;

  _NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.type,
  });

  Color getColor() {
    switch (type) {
      case _NotificationType.alert:
        return Colors.redAccent;
      case _NotificationType.success:
        return Colors.green;
      case _NotificationType.warning:
        return Colors.orangeAccent;
      case _NotificationType.info:
        return AppTheme.primaryBlue;
    }
  }

  IconData getIcon() {
    switch (type) {
      case _NotificationType.alert:
        return Icons.warning_rounded;
      case _NotificationType.success:
        return Icons.check_circle_rounded;
      case _NotificationType.warning:
        return Icons.battery_alert_rounded;
      case _NotificationType.info:
        return Icons.info_rounded;
    }
  }
}
