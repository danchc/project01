import 'alimento.dart';

class Alimentazione {

  String? id;
  final String nome;
  final List<dynamic> alimenti;

  Alimentazione({
    this.id = '',
    required this.nome,
    required this.alimenti,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'alimenti': alimenti
  };

  static Alimentazione fromJson(Map<String, dynamic> json) =>
      Alimentazione(
        id: json['id'],
        nome: json['nome'],
        alimenti: json['alimenti']
      );
}
