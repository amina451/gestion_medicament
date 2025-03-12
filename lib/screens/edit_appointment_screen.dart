import 'package:flutter/material.dart';
import 'package:gestion_medicament/models/appointment_model.dart';
import 'package:gestion_medicament/providers/appointment_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditAppointmentScreen extends StatefulWidget {
  final Appointment appointment;
  const EditAppointmentScreen({super.key, required this.appointment});

  @override
  _EditAppointmentScreenState createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _doctorNameController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _doctorNameController =
        TextEditingController(text: widget.appointment.doctorName);
    _dateController = TextEditingController(text: widget.appointment.date);
    _timeController = TextEditingController(text: widget.appointment.time);
    _notesController = TextEditingController(text: widget.appointment.notes);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  @override
  void dispose() {
    _doctorNameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Appointment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _doctorNameController,
                  decoration: const InputDecoration(labelText: 'Doctor Name')),
              TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  readOnly: true,
                  onTap: () => _selectDate(context)),
              TextFormField(
                  controller: _timeController,
                  decoration: const InputDecoration(labelText: 'Time'),
                  readOnly: true,
                  onTap: () => _selectTime(context)),
              TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(labelText: 'Notes')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedAppointment = Appointment(
                      id: widget.appointment.id,
                      doctorName: _doctorNameController.text,
                      date: _dateController.text,
                      time: _timeController.text,
                      notes: _notesController.text,
                    );
                    Provider.of<AppointmentProvider>(context, listen: false)
                        .updateAppointment(updatedAppointment);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
