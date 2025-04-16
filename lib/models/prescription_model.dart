class Prescription {
  final int? id;
  final int medicamentId;
  final int medecinId;
  final String instructions;

  Prescription({
    this.id,
    required this.medicamentId,
    required this.medecinId,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicamentId': medicamentId,
      'medecinId': medecinId,
      'instructions': instructions,
    };
  }

  factory Prescription.fromMap(Map<String, dynamic> map) {
    return Prescription(
      id: map['id'],
      medicamentId: map['medicamentId'],
      medecinId: map['medecinId'],
      instructions: map['instructions'],
    );
  }
}
