class MedecinModel {
  final int? id;
  final String nom;
  final String specialite;
  final String telephone;

  MedecinModel({
    this.id,
    required this.nom,
    required this.specialite,
    required this.telephone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'specialite': specialite,
      'telephone': telephone,
    };
  }

  factory MedecinModel.fromMap(Map<String, dynamic> map) {
    return MedecinModel(
      id: map['id'],
      nom: map['nom'],
      specialite: map['specialite'],
      telephone: map['telephone'],
    );
  }
}
