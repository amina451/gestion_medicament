import 'package:flutter/material.dart';
import 'medecin_list_screen.dart';
import 'rendezvous_list_screen.dart';
import 'medicament_list_screen.dart';
import 'prescription_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مدير الصحة"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildTile(
            context,
            icon: Icons.person,
            title: "الأطباء",
            color: Colors.teal,
            screen: const MedecinListScreen(),
          ),
          _buildTile(
            context,
            icon: Icons.calendar_today,
            title: "المواعيد",
            color: Colors.indigo,
            screen: const RendezVousListScreen(),
          ),
          _buildTile(
            context,
            icon: Icons.medication,
            title: "الأدوية",
            color: Colors.deepOrange,
            screen: const MedicamentListScreen(),
          ),
          _buildTile(
            context,
            icon: Icons.receipt_long,
            title: "الوصفات",
            color: Colors.purple,
            screen: const PrescriptionListScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon,
        required String title,
        required Color color,
        required Widget screen}) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
