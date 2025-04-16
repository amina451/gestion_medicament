import 'package:flutter/material.dart';
import 'package:gestion_medicament/models/medicament_model.dart';
import 'package:provider/provider.dart';
import '../../providers/prescription_provider.dart';
import '../../providers/medicament_provider.dart';
import 'prescription_form_screen.dart';

class PrescriptionListScreen extends StatelessWidget {
  const PrescriptionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prescriptionProvider = Provider.of<PrescriptionProvider>(context);
    final medicamentProvider = Provider.of<MedicamentProvider>(context);

    final prescriptions = prescriptionProvider.prescriptions;
    final medicaments = medicamentProvider.medicaments;

    return Scaffold(
      appBar: AppBar(title: const Text('الوصفات الطبية')),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          final prescription = prescriptions[index];

          // البحث عن الدواء المرتبط بالوصفة حسب الـ medicamentId
          final medicament = medicaments.firstWhere(
                (med) => med.id == prescription.medicamentId,
            orElse: () => MedicamentModel(
              id: 0,
              nom: 'غير معروف',
              description: '',
              dosage: '',
              reminderTime: DateTime.now(),
            ),
          );

          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text("وصفة رقم: ${prescription.id}"),
              subtitle: Text("الدواء: ${medicament.nom}\nتعليمات: ${prescription.instructions}"),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PrescriptionFormScreen(prescription: prescription),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => prescriptionProvider.deletePrescription(prescription.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PrescriptionFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
