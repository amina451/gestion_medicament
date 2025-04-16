import 'package:gestion_medicament/database_helper.dart';
import 'package:gestion_medicament/models/prescription_model.dart';

class PrescriptionRepository {
  final dbHelper = DatabaseHelper();

  Future<int> insertPrescription(Prescription prescription) async {
    final db = await dbHelper.database;
    return await db.insert('prescriptions', prescription.toMap());
  }

  Future<List<Prescription>> getAllPrescriptions() async {
    final db = await dbHelper.database;
    final maps = await db.query('prescriptions');
    return maps.map((e) => Prescription.fromMap(e)).toList();
  }

  Future<int> updatePrescription(Prescription prescription) async {
    final db = await dbHelper.database;
    return await db.update(
      'prescriptions',
      prescription.toMap(),
      where: 'id = ?',
      whereArgs: [prescription.id],
    );
  }

  Future<int> deletePrescription(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'prescriptions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
