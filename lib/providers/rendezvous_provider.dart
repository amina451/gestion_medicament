import 'package:flutter/material.dart';
import '../models/rendezvous_model.dart';
import '../repositories/rendezvous_repository.dart';

class RendezVousProvider extends ChangeNotifier {
  final List<RendezVous> _rendezvousList = [];

  List<RendezVous> get rendezvous => _rendezvousList;

  Future<void> fetchRendezVousList() async {
    final data = await RendezVousRepository.getAllRendezVous();
    _rendezvousList.clear();
    _rendezvousList.addAll(data);
    notifyListeners();
  }

  Future<void> addRendezVous(RendezVous rendezVous) async {
    await RendezVousRepository.insertRendezVous(rendezVous);
    await fetchRendezVousList();
  }

  Future<void> updateRendezVous(RendezVous rendezVous) async {
    await RendezVousRepository.updateRendezVous(rendezVous);
    await fetchRendezVousList();
  }

  Future<void> deleteRendezVous(int id) async {
    await RendezVousRepository.deleteRendezVous(id);
    await fetchRendezVousList();
  }
}
