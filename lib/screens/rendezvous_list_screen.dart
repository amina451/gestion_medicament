import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/rendezvous_provider.dart';
import 'rendezvous_form_screen.dart';

class RendezVousListScreen extends StatelessWidget {
  const RendezVousListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RendezVousProvider>(context);
    final rendezvousList = provider.rendezvous;


    return Scaffold(
      appBar: AppBar(title: const Text('قائمة المواعيد')),
      body: ListView.builder(
        itemCount: rendezvousList.length,
        itemBuilder: (context, index) {
          final rdv = rendezvousList[index];
          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(rdv.titre),
              subtitle: Text(rdv.dateTime.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.indigo),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RendezVousFormScreen(rendezVous: rdv),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.deleteRendezVous(rdv.id!),
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
          MaterialPageRoute(builder: (_) => const RendezVousFormScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
