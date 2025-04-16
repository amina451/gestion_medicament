import 'package:flutter/material.dart';
import 'package:gestion_medicament/models/medicament_model.dart';
import 'package:gestion_medicament/repositories/medicament_repository.dart';

class MedicamentProvider with ChangeNotifier {
  final _repo = MedicamentRepository();
  List<MedicamentModel> _medicaments = [];

  List<MedicamentModel> get medicaments => _medicaments;

  Future<void> fetchMedicaments() async {
    _medicaments = await _repo.getAllMedicaments();
    notifyListeners();
  }

  Future<void> addMedicament(MedicamentModel medicament) async {
    await _repo.insertMedicament(medicament);
    await fetchMedicaments();
  }

  Future<void> updateMedicament(MedicamentModel medicament) async {
    await _repo.updateMedicament(medicament);
    await fetchMedicaments();
  }

  Future<void> deleteMedicament(int id) async {
    await _repo.deleteMedicament(id);
    await fetchMedicaments();
  }
}
