import 'package:flutter/cupertino.dart';
import 'package:mcproject/model/esercizio.dart';

import '../model/workout.dart';

/**
 * Struttura base del workout.
 */

class WorkoutData extends ChangeNotifier{

  /* default */
  List<Workout> listaWorkout = [
    Workout(
        nome: 'Workout',
        esercizi: [
          Esercizio(
            nome: 'Esercizio',
            reps: '10',
            sets: '3',
            peso: '20'
          )
        ])
  ];

  /* get lista workout */
  List<Workout> getListWorkout() {
    return listaWorkout;
  }

  /* aggiungi workout */
  void addWorkout(String nome) {
    listaWorkout.add(Workout(nome: nome, esercizi: []));
    notifyListeners();
  }

  /* aggiungi esercizio */
  void addEsercizio(String nomeWorkout, String nome, String reps, String sets, String peso) {

    /* cerca il workout corrente */
    Workout corrente =
        listaWorkout.firstWhere((workout) => workout.nome == nomeWorkout);

    /* aggiungi esercizio al workout corrente */
    corrente.esercizi.add(
      Esercizio(nome: nome, reps: reps, sets: sets, peso: peso)
    );

    notifyListeners();
  }

}
