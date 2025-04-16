enum TypeNotification { rendezVous, medicament }
enum StatutNotification { enAttente, envoye }

class NotificationModel {
  final int? id;
  final String message;
  final DateTime dateEnvoi;
  final TypeNotification type;
  final StatutNotification statut;
  final int? rendezVousId;

  NotificationModel({
    this.id,
    required this.message,
    required this.dateEnvoi,
    required this.type,
    required this.statut,
    this.rendezVousId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'dateEnvoi': dateEnvoi.toIso8601String(),
      'type': type.name,
      'statut': statut.name,
      'rendezVousId': rendezVousId,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      message: map['message'],
      dateEnvoi: DateTime.parse(map['dateEnvoi']),
      type: TypeNotification.values.byName(map['type']),
      statut: StatutNotification.values.byName(map['statut']),
      rendezVousId: map['rendezVousId'],
    );
  }
}
