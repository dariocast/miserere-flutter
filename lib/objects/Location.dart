class Location {
  final String id;
  final String confraternitaId;
  final String lat;
  final String lon;
  final String tag;
  final String ora;

  Location({this.id, this.confraternitaId, this.lat, this.lon, this.tag,
      this.ora});

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