import 'package:gestion_medicament/database_helper.dart';
import 'package:gestion_medicament/models/medicament_model.dart';

class MedicamentRepository {
  final dbHelper = DatabaseHelper();

  Future<int> insertMedicament(MedicamentModel medicament) async {
    final db = await dbHelper.database;
    return await db.insert('medicaments', medicament.toMap());
  }

  Future<List<MedicamentModel>> getAllMedicaments() async {
    final db = await dbHelper.database;
    final maps = await db.query('medicaments');
    return maps.map((e) => MedicamentModel.fromMap(e)).toList();
  }

  Future<int> updateMedicament(MedicamentModel medicament) async {
    final db = await dbHelper.database;
    return await db.update(
      'medicaments',
      medicament.toMap(),
      where: 'id = ?',
      whereArgs: [medicament.id],
    );
  }

  Future<int> deleteMedicament(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'medicaments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
