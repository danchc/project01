import 'sessione.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1, adapterName: 'WorkoutAdapter')
class Workout extends HiveObject{

  String? id;
  final String nome;
  final List<dynamic> sessioni;

  Workout ({
    this.id = '',
    required this.nome,
    required this.sessioni
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'sessioni': sessioni,
  };

  static Workout fromJson(Map<String, dynamic> json) =>
      Workout(
          id: json['id'],
          nome: json['nome'],
          sessioni: json['sessioni']
      );

}
