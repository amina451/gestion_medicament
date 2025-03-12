import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gestion_medicament/screens/start_screen.dart';
import 'package:provider/provider.dart';
import 'providers/medicine_provider.dart';
import 'providers/appointment_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تشغيل تطبيق Flutter مع Provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MedicineProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Médicaments et Rendez-vous',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartScreen(), // افتح StartScreen كشاشة أولية
      debugShowCheckedModeBanner: false, // إزالة شعار Debug
    );
  }
}
