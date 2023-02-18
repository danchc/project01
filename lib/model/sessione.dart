import 'esercizio.dart';

class Sessione {

  String id;
  final String nome;
  final List<dynamic> esercizi;

  Sessione ({
    this.id = '',
    required this.nome,
    required this.esercizi
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'esercizi': esercizi
  };

  static Sessione fromJson(Map<String, dynamic> json) =>
      Sessione(
          id: json['id'],
          nome: json['nome'],
          esercizi: json['esercizi']
      );
}
