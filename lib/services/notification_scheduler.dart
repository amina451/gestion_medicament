// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationScheduler {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();

//   static Future<void> initializeNotifications() async {
//     tz.initializeTimeZones();
//     tz.setLocalLocation(tz.getLocation('Africa/Casablanca'));

//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//   }

//   static Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     final tz.TZDateTime tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

//     await _notificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tzScheduledTime,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'medicaments_channel_id',
//           'Medicaments Notifications',
//           channelDescription: 'Notification pour rappel de médicament',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }
