import 'package:gestion_medicament/database_helper.dart';
import 'package:gestion_medicament/models/rendezvous_model.dart';

class RendezVousRepository {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  static Future<List<RendezVous>> getAllRendezVous() async {
    final db = await _dbHelper.database;
    final maps = await db.query('rendezvous');
    return maps.map((e) => RendezVous.fromMap(e)).toList();
  }

  static Future<void> insertRendezVous(RendezVous rendezVous) async {
    final db = await _dbHelper.database;
    await db.insert('rendezvous', rendezVous.toMap());
  }

  static Future<void> updateRendezVous(RendezVous rendezVous) async {
    final db = await _dbHelper.database;
    await db.update(
      'rendezvous',
      rendezVous.toMap(),
      where: 'id = ?',
      whereArgs: [rendezVous.id],
    );
  }

  static Future<void> deleteRendezVous(int id) async {
    final db = await _dbHelper.database;
    await db.delete('rendezvous', where: 'id = ?', whereArgs: [id]);
  }
}
