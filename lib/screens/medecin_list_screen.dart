import 'package:flutter/material.dart';
import '../../providers/medecin_provider.dart';
import 'medecin_form_screen.dart';
import 'package:provider/provider.dart';

class MedecinListScreen extends StatelessWidget {
  const MedecinListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedecinProvider>(context);
    final medecins = provider.medecins;

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الأطباء'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: medecins.isEmpty
          ? const Center(child: Text("لا يوجد أطباء حالياً"))
          : ListView.builder(
        itemCount: medecins.length,
        itemBuilder: (context, index) {
          final medecin = medecins[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.teal),
              title: Text(medecin.nom),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medecin.specialite),
                  if (medecin.telephone != null)
                    Text('📞 ${medecin.telephone!}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MedecinFormScreen(
                            medecin: medecin,
                            onSave: (updatedMedecin) {
                              provider.updateMedecin(updatedMedecin);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      provider.deleteMedecin(medecin.id!);
                    },
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
            MaterialPageRoute(
              builder: (_) => MedecinFormScreen(
                onSave: (newMedecin) {
                  provider.addMedecin(newMedecin);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
