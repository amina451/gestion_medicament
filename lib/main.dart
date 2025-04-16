import 'package:flutter/material.dart';
import 'package:gestion_medicament/services/local_notifications.dart';
import 'package:provider/provider.dart';

import 'screens/medicament_list_screen.dart';
import 'screens/rendezvous_list_screen.dart';
import 'screens/prescription_list_screen.dart';

import 'providers/medicament_provider.dart';
import 'providers/rendezvous_provider.dart';
import 'providers/prescription_provider.dart';

import 'services/background_task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔔 تهيئة الإشعارات
  // await NotificationHelper.initialize();

  // ⚙️ تهيئة خدمة الخلفية
  await BackgroundService.initializeService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => MedicamentProvider()..fetchMedicaments()),
        ChangeNotifierProvider(
            create: (_) => RendezVousProvider()..fetchRendezVousList()),
        ChangeNotifierProvider(
            create: (_) => PrescriptionProvider()..fetchPrescriptions()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'تطبيق إدارة الأدوية',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: const Color(0xFFF2F2F2),
          appBarTheme: const AppBarTheme(
            elevation: 2,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.teal,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             NotificationHelper.showNotification(
//                 "this is for test", "this notification is just for testing");
//           },
//           child: Text("Show"),
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إدارة الأدوية والمواعيد')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMenuButton(
            context,
            title: '📋 قائمة الأدوية',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MedicamentListScreen()),
            ),
          ),
          _buildMenuButton(
            context,
            title: '📅 قائمة المواعيد',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RendezVousListScreen()),
            ),
          ),
          _buildMenuButton(
            context,
            title: '💊 قائمة الوصفات',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrescriptionListScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context,
      {required String title, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
