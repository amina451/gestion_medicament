// // da marahch mtala3 l package aslan
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationHelper {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // tz.initializeTimeZones();
//     // tz.setLocalLocation(tz.getLocation('Africa/Casablanca')); // غيّر منطقتك إذا لزم الأمر

//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//   }

//   static Future<void> showNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminders',
//       channelDescription: 'تذكيرات عامة',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(android: androidDetails);

//     await _notificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       details,
//     );
//   }

//   static Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminders',
//       channelDescription: 'تذكيرات مجدولة',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details = NotificationDetails(android: androidDetails);

//     final tz.TZDateTime tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

//     await _notificationsPlugin.zonedSchedule(
//       tzTime.millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       tzTime,
//       details,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_name',
      'Something Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
    );
  }
}
