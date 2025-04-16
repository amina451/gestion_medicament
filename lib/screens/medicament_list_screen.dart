import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/medicament_provider.dart';
import 'medicament_form_screen.dart';

class MedicamentListScreen extends StatelessWidget {
  const MedicamentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicamentProvider>(context);
    final medicaments = provider.medicaments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الأدوية'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: medicaments.isEmpty
          ? const Center(child: Text("لا توجد أدوية بعد."))
          : ListView.builder(
        itemCount: medicaments.length,
        itemBuilder: (context, index) {
          final med = medicaments[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(med.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("وقت التذكير: ${med.reminderTime.toString()}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MedicamentFormScreen(medicament: med),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.deleteMedicament(med.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MedicamentFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
