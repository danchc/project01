/**
 * Un esercizio è composto da :
 * -nome
 * -reps
 * -sets
 * -peso
 */

class Esercizio {

  String id;
  final String nome;
  final String reps;
  final String sets;
  final String peso;

  Esercizio({
    this.id = '',
    required this.nome,
    required this.reps,
    required this.sets,
    required this.peso
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'reps': reps,
    'sets': sets,
    'peso': peso,
  };

  static Esercizio fromJson(Map<String, dynamic> json) =>
      Esercizio(
          id: json['id'],
          nome: json['nome'],
          reps: json['reps'],
          sets: json['sets'],
          peso: json['peso'],
      );
}
