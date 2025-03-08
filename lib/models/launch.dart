class Launch {
  final String id;
  final String missionName;
  final String? missionPatch;
  final DateTime launchDate;
  final bool? success;
  final String? details;

  Launch({
    required this.id,
    required this.missionName,
    required this.missionPatch,
    required this.launchDate,
    required this.success,
    required this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      id: json['id'],
      missionName: json['name'] ?? 'Unknown Mission',
      missionPatch: json['links']['patch']['large'],
      launchDate: DateTime.parse(json['date_utc']),
      success: json['success'],
      details: json['details'],
    );
  }
}
