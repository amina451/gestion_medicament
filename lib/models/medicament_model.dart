class MedicamentModel {
  final int? id;
  final String nom;
  final String description;
  final String dosage;
  final DateTime reminderTime;

  MedicamentModel({
    this.id,
    required this.nom,
    required this.description,
    required this.dosage,
    required this.reminderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'dosage': dosage,
      'reminderTime': reminderTime.toIso8601String(),
    };
  }

  factory MedicamentModel.fromMap(Map<String, dynamic> map) {
    return MedicamentModel(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      dosage: map['dosage'],
      reminderTime: DateTime.parse(map['reminderTime']),
    );
  }
}
