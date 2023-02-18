/**
 * Un alimento è composto da :
 * -nome
 * -peso dell'alimento
 * -giorno
 */

class Alimento {

  String id;
  final String nome;
  final String peso;
  final String giorno;

  Alimento({
    this.id = '',
    required this.nome,
    required this.peso,
    required this.giorno,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'peso': peso,
    'giorno': giorno
  };

  static Alimento fromJson(Map<String, dynamic> json) =>
      Alimento(
          id: json['id'],
          nome: json['nome'],
          peso: json['peso'],
          giorno: json['giorno'],
      );
}
