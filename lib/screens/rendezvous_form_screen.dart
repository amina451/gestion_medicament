import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/rendezvous_model.dart';
import '../../providers/rendezvous_provider.dart';
import '../../services/notification_scheduler.dart';

class RendezVousFormScreen extends StatefulWidget {
  final RendezVous? rendezVous;

  const RendezVousFormScreen({super.key, this.rendezVous});

  @override
  State<RendezVousFormScreen> createState() => _RendezVousFormScreenState();
}

class _RendezVousFormScreenState extends State<RendezVousFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.rendezVous?.titre ?? '');
    _descriptionController =
        TextEditingController(text: widget.rendezVous?.description ?? '');
    _selectedDateTime = widget.rendezVous?.dateTime;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (time != null && mounted) {
        setState(() {
          _selectedDateTime =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        });
      }
    }
  }

  void _saveRendezVous() async {
    if (_formKey.currentState!.validate() && _selectedDateTime != null) {
      final rdv = RendezVous(
        id: widget.rendezVous?.id,
        titre: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        dateTime: _selectedDateTime!,
      );

      final provider = Provider.of<RendezVousProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      if (widget.rendezVous == null) {
        provider.addRendezVous(rdv);
      } else {
        provider.updateRendezVous(rdv);
      }

      // await NotificationScheduler.scheduleNotification(
      //   id: rdv.id ?? 0,
      //   title: "تذكير بموعد",
      //   body: rdv.titre,
      //   scheduledTime: rdv.dateTime,
      // );

      navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.rendezVous == null ? 'إضافة موعد' : 'تعديل موعد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'عنوان الموعد'),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال العنوان' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف'),
                validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال الوصف' : null,
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(_selectedDateTime == null
                    ? 'اختر التاريخ والوقت'
                    : _selectedDateTime.toString()),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDateTime,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('حفظ'),
                onPressed: _saveRendezVous,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
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
