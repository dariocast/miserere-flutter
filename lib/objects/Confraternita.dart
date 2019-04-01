class Confraternita {
  final String id;
  final String nome;
  final String urlFoto;
  final String urlAudio;
  final String urlInfo;
  final String urlIcona;

  Confraternita(
      {this.id,
      this.nome,
      this.urlFoto,
      this.urlAudio,
      this.urlInfo,
      this.urlIcona});

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
