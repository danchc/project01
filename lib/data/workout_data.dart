import 'package:flutter/cupertino.dart';
import 'package:mcproject/model/esercizio.dart';

import '../model/sessione.dart';

/**
 * Struttura base del workout.
 */

class WorkoutData extends ChangeNotifier{

  /* default */
  List<Sessione> listaWorkout = [
    Sessione(
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
  List<Sessione> getListWorkout() {
    return listaWorkout;
  }

  /* aggiungi workout */
  void addWorkout(String nome) {
    listaWorkout.add(Sessione(nome: nome, esercizi: []));
    notifyListeners();
  }

  /* aggiungi esercizio */
  void addEsercizio(String nomeWorkout, String nome, String reps, String sets, String peso) {

    /* cerca il workout corrente */
    Sessione corrente =
        getWorkoutCorrente(nomeWorkout);

    /* aggiungi esercizio al workout corrente */
    corrente.esercizi.add(
      Esercizio(nome: nome, reps: reps, sets: sets, peso: peso)
    );

    notifyListeners();
  }

  //cerca il workout corrente
  Sessione getWorkoutCorrente(String nomeWorkout) {
    return listaWorkout.firstWhere((workout) => workout.nome == nomeWorkout);
  }

  //metodo per restituire il numero di esercizi del workout corrente
  int numeroEserciziWorkoutCorrente(String nomeWorkout) {
    Sessione corrente = getWorkoutCorrente(nomeWorkout);

    return corrente.esercizi.length;
  }

  //metodo per cercare l'esercizio corrente
}
