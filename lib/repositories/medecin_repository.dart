import 'package:gestion_medicament/database_helper.dart';
import 'package:gestion_medicament/models/medecin_model.dart';

class MedecinRepository {
  final dbHelper = DatabaseHelper();

  Future<int> insertMedecin(MedecinModel medecin) async {
    final db = await dbHelper.database;
    return await db.insert('medecins', medecin.toMap());
  }

  Future<List<MedecinModel>> getAllMedecins() async {
    final db = await dbHelper.database;
    final maps = await db.query('medecins');
    return maps.map((e) => MedecinModel.fromMap(e)).toList();
  }

  Future<int> updateMedecin(MedecinModel medecin) async {
    final db = await dbHelper.database;
    return await db.update(
      'medecins',
      medecin.toMap(),
      where: 'id = ?',
      whereArgs: [medecin.id],
    );
  }

  Future<int> deleteMedecin(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'medecins',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
