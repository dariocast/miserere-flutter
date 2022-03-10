class Confraternita {
  final String id;
  final String nome;
  final String urlFoto;
  final String urlAudio;
  final String urlInfo;
  final String urlIcona;

  Confraternita({
    required this.id,
    required this.nome,
    required this.urlFoto,
    required this.urlAudio,
    required this.urlInfo,
    required this.urlIcona,
  });

  factory Confraternita.fromJson(Map<String, dynamic> json) {
    return Confraternita(
        id: json['id'],
        nome: json['nome'],
        urlFoto: json['urlFoto'],
        urlAudio: json['urlAudio'],
        urlInfo: json['urlInfo'],
        urlIcona: json['urlIcona']);
  }
}
