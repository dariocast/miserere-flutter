class Giorno {
  final String id;
  final String nome;
  final String data;

  Giorno(
      {
        this.id,
        this.nome,
        this.data
      });

  factory Giorno.fromJson(Map<String, dynamic> json) {
    return Giorno(
        id: json['id'],
        nome: json['nome'],
        data: json['data']
    );
  }
}