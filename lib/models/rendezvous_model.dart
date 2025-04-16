class RendezVous {
  final int? id;
  final String titre;
  final String description;
  final DateTime dateTime;

  RendezVous({
    this.id,
    required this.titre,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titre': titre,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory RendezVous.fromMap(Map<String, dynamic> map) {
    return RendezVous(
      id: map['id'],
      titre: map['titre'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}
