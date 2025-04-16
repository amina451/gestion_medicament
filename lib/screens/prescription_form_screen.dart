import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/prescription_model.dart';
import '../../providers/prescription_provider.dart';
import '../../providers/medicament_provider.dart';
import '../../services/notification_scheduler.dart';

class PrescriptionFormScreen extends StatefulWidget {
  final Prescription? prescription;

  const PrescriptionFormScreen({super.key, this.prescription});

  @override
  State<PrescriptionFormScreen> createState() => _PrescriptionFormScreenState();
}

class _PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedMedicamentId;
  final _instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.prescription != null) {
      _selectedMedicamentId = widget.prescription!.medicamentId;
      _instructionsController.text = widget.prescription!.instructions;
    }

    // تحميل الأدوية عند بدء الشاشة
    Provider.of<MedicamentProvider>(context, listen: false).fetchMedicaments();
  }

  Future<void> _savePrescription() async {
    if (_formKey.currentState!.validate()) {
      final newPrescription = Prescription(
        id: widget.prescription?.id,
        medicamentId: _selectedMedicamentId!,
        medecinId: 1, // يمكن تخصيصه لاحقًا إن أردت إدخال الطبيب
        instructions: _instructionsController.text.trim(),
      );

      final provider = context.read<PrescriptionProvider>();
      final navigator = Navigator.of(context);
      if (widget.prescription == null) {
        await provider.addPrescription(newPrescription);
      } else {
        await provider.updatePrescription(newPrescription);
      }

      // 🔔 جدولة تذكير إشعاري بعد دقيقة من الآن
      // await NotificationScheduler.scheduleNotification(
      //   id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      //   title: "وصفة طبية",
      //   body: "تذكير بتناول الدواء حسب الوصفة.",
      //   scheduledTime: DateTime.now().add(const Duration(minutes: 1)),
      // );
      // ki tdiri haka nti w zahrek la ydir pop gotlk 3liha
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final medicaments = Provider.of<MedicamentProvider>(context).medicaments;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.prescription == null ? 'إضافة وصفة' : 'تعديل الوصفة'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'اختر الدواء'),
                value: _selectedMedicamentId,
                items: medicaments.map((med) {
                  return DropdownMenuItem<int>(
                    value: med.id,
                    child: Text(med.nom),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedMedicamentId = val;
                  });
                },
                validator: (value) => value == null ? 'يرجى اختيار دواء' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration:
                    const InputDecoration(labelText: 'تعليمات الاستخدام'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'يرجى إدخال التعليمات'
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(widget.prescription == null ? 'حفظ' : 'تحديث'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: _savePrescription,
              )
            ],
          ),
        ),
      ),
    );
  }
}
