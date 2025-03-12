import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine_model.dart';
import '../providers/medicine_provider.dart';

class EditMedicineScreen extends StatelessWidget {
  final Medicine medicine;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _frequencyController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
 
  EditMedicineScreen({super.key, required this.medicine}) {
    _nameController.text = medicine.name;
    _dosageController.text = medicine.dosage;
    _frequencyController.text = medicine.frequency;
    _startDateController.text = medicine.startDate;
    _endDateController.text = medicine.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le Médicament'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom du Médicament'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dosageController,
                decoration: InputDecoration(labelText: 'Dosage'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un dosage';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _frequencyController,
                decoration: InputDecoration(labelText: 'Fréquence'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une fréquence';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Date de début'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date de début';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'Date de fin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date de fin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Medicine updatedMedicine = Medicine(
                      id: medicine.id,
                      name: _nameController.text,
                      dosage: _dosageController.text,
                      frequency: _frequencyController.text,
                      startDate: _startDateController.text,
                      endDate: _endDateController.text,
                    );
                    Provider.of<MedicineProvider>(context, listen: false)
                        .updateMedicine(updatedMedicine);
                   
                   
                    Navigator.pop(context);
                  }
                },
                child: Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
