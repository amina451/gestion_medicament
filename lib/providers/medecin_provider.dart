import 'package:flutter/material.dart';
import 'package:gestion_medicament/models/medecin_model.dart';
import 'package:gestion_medicament/repositories/medecin_repository.dart';

class MedecinProvider with ChangeNotifier {
  final _repo = MedecinRepository();
  List<MedecinModel> _medecins = [];

  List<MedecinModel> get medecins => _medecins;

  Future<void> fetchMedecins() async {
    _medecins = await _repo.getAllMedecins();
    notifyListeners();
  }

  Future<void> addMedecin(MedecinModel medecin) async {
    await _repo.insertMedecin(medecin);
    await fetchMedecins();
  }

  Future<void> updateMedecin(MedecinModel medecin) async {
    await _repo.updateMedecin(medecin);
    await fetchMedecins();
  }

  Future<void> deleteMedecin(int id) async {
    await _repo.deleteMedecin(id);
    await fetchMedecins();
  }
}
