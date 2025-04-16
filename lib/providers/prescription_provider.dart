import 'package:flutter/material.dart';
import 'package:gestion_medicament/models/prescription_model.dart';
import 'package:gestion_medicament/repositories/prescription_repository.dart';

class PrescriptionProvider with ChangeNotifier {
  final _repo = PrescriptionRepository();
  List<Prescription> _prescriptions = [];

  List<Prescription> get prescriptions => _prescriptions;

  Future<void> fetchPrescriptions() async {
    _prescriptions = await _repo.getAllPrescriptions();
    notifyListeners();
  }

  Future<void> addPrescription(Prescription prescription) async {
    await _repo.insertPrescription(prescription);
    await fetchPrescriptions();
  }

  Future<void> updatePrescription(Prescription prescription) async {
    await _repo.updatePrescription(prescription);
    await fetchPrescriptions();
  }

  Future<void> deletePrescription(int id) async {
    await _repo.deletePrescription(id);
    await fetchPrescriptions();
  }
}
