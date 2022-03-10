class Location {
  final String id;
  final String confraternitaId;
  final String lat;
  final String lon;
  final String tag;
  final String ora;

  Location({
    required this.id,
    required this.confraternitaId,
    required this.lat,
    required this.lon,
    required this.tag,
    required this.ora,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        confraternitaId: json['confraternitaId'],
        lat: json['lat'],
        lon: json['lon'],
        tag: json['tag'],
        ora: json['ora']);
  }
}
