import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:gestion_medicament/database_helper.dart';
import 'local_notifications.dart';

@pragma('vm:entry-point')
class BackgroundService {
  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: true,
        onStart: onStart,
        isForegroundMode: true,
        autoStartOnBoot: true,
        foregroundServiceNotificationId: 800,
      ),
    );
  }

  static void startBackgroundService() {
    FlutterBackgroundService().startService();
  }

  static void stopBackgroundService() {
    FlutterBackgroundService().invoke("stopService");
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
      service.setForegroundNotificationInfo(
        title: "تشغيل في الخلفية",
        content: "تطبيق إدارة الأدوية يعمل الآن في الخلفية",
      );
    }

    await NotificationHelper.initialize(); // تهيئة الإشعارات

    service.on("stopService").listen((event) {
      service.stopSelf();
    });

    // Initialize the database helper
    final dbHelper = DatabaseHelper();

    Timer.periodic(const Duration(minutes: 5), (timer) async {
      debugPrint("⏳ خدمة الخلفية تعمل...");

      // Get the current time
      final now = DateTime.now();

      // Fetch all medicaments from the database
      final medicaments = await dbHelper.getAllMedicaments();
      log(medicaments.toString());

      for (var medicament in medicaments) {
        final reminderTime = DateTime.parse(medicament['reminderTime']);
        final difference = reminderTime.difference(now).inMinutes;

        if (difference > 0 && difference <= 5) {
          // Trigger a notification for the medicament
          await NotificationHelper.showNotification(
            "تذكير: ${medicament['nom']}",
            "تبقى أقل من 5 دقائق لتناول الدواء: ${medicament['nom']}",
          );
          debugPrint("🔔 تذكير: ${medicament['nom']} - أقل من 5 دقائق");
        }
      }
    });
  }
}
