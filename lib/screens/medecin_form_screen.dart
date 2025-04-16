import 'package:flutter/material.dart';
import '../../models/medecin_model.dart';

class MedecinFormScreen extends StatefulWidget {
  final MedecinModel? medecin;
  final Function(MedecinModel) onSave;

  const MedecinFormScreen({super.key, this.medecin, required this.onSave});

  @override
  State<MedecinFormScreen> createState() => _MedecinFormScreenState();
}

class _MedecinFormScreenState extends State<MedecinFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.medecin != null) {
      _nomController.text = widget.medecin!.nom;
      _specialiteController.text = widget.medecin!.specialite;
      _telephoneController.text = widget.medecin!.telephone;
    }
  }

  void _saveMedecin() {
    if (_formKey.currentState!.validate()) {
      final medecin = MedecinModel(
        id: widget.medecin?.id,
        nom: _nomController.text.trim(),
        specialite: _specialiteController.text.trim(),
        telephone: _telephoneController.text.trim(),
      );
      widget.onSave(medecin);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.medecin == null ? 'إضافة طبيب' : 'تعديل طبيب'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال الاسم' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _specialiteController,
                decoration: const InputDecoration(
                  labelText: 'التخصص',
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال التخصص' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _telephoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('حفظ'),
                onPressed: _saveMedecin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
