import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/medicament_model.dart';
import '../../providers/medicament_provider.dart';
import '../../services/notification_scheduler.dart';

class MedicamentFormScreen extends StatefulWidget {
  final MedicamentModel? medicament;

  const MedicamentFormScreen({super.key, this.medicament});

  @override
  State<MedicamentFormScreen> createState() => _MedicamentFormScreenState();
}

class _MedicamentFormScreenState extends State<MedicamentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _dosageController;
  DateTime? _reminderDateTime;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicament?.nom ?? '');
    _descriptionController =
        TextEditingController(text: widget.medicament?.description ?? '');
    _dosageController =
        TextEditingController(text: widget.medicament?.dosage ?? '');
    _reminderDateTime = widget.medicament?.reminderTime;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  Future<void> _pickReminderTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      if (!mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_reminderDateTime ?? DateTime.now()),
      );
      if (time != null) {
        setState(() {
          _reminderDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  Future<void> _saveMedicament() async {
    if (_formKey.currentState!.validate() && _reminderDateTime != null) {
      final med = MedicamentModel(
        id: widget.medicament?.id,
        nom: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        dosage: _dosageController.text.trim(),
        reminderTime: _reminderDateTime!,
      );

      final provider = Provider.of<MedicamentProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      if (widget.medicament == null) {
        provider.addMedicament(med);
      } else {
        provider.updateMedicament(med);
      }

      // 🔔 جدولة الإشعار
      // await NotificationScheduler.scheduleNotification(
      //   id: med.id ?? 0,
      //   title: "تذكير بالدواء",
      //   body: "${med.nom} - ${med.dosage}",
      //   scheduledTime: med.reminderTime,
      // );

      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.medicament == null ? 'إضافة دواء' : 'تعديل دواء')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'اسم الدواء'),
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال الاسم' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف'),
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال الوصف' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(labelText: 'الجرعة'),
                validator: (value) =>
                    value!.isEmpty ? 'يرجى إدخال الجرعة' : null,
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  _reminderDateTime == null
                      ? 'اختر وقت التذكير'
                      : 'وقت التذكير: ${_reminderDateTime.toString()}',
                ),
                trailing: const Icon(Icons.alarm),
                onTap: _pickReminderTime,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('حفظ'),
                onPressed: _saveMedicament,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
