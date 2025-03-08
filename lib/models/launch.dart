class Launch {
  final String missionName;
  final String? missionPatch;
  final DateTime launchDate;
  final bool? success;
  final String? details;

  Launch({
    required this.missionName,
    this.missionPatch,
    required this.launchDate,
    this.success,
    this.details,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['name'] ?? 'Unknown Mission',
      missionPatch: json['links']['patch']['small'],
      launchDate: DateTime.parse(json['date_utc']),
      success: json['success'],
      details: json['details'],
    );
  }
}
