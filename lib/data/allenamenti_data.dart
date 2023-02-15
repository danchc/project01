import 'package:flutter/material.dart';
import 'package:mcproject/model/esercizio.dart';
import 'package:mcproject/model/sessione.dart';
import 'package:mcproject/model/workout.dart';

/**
 * Struttura base di una scheda di allenamento.
 */

class AllenamentiData extends ChangeNotifier{

  /* default */
  List<Workout> listaSchede = [];

  /* metodo per recuperare listaSchede */
  List<Workout> getListaSchede() {
    return listaSchede;
  }

  /* metodo per aggiungere nuova scheda */
  void addScheda(String nome) {
    listaSchede.add(Workout(nome: nome, sessioni: []));
    notifyListeners();
  }

  Workout getSchedaCorrente(String nome) {
    return listaSchede.firstWhere((scheda) => scheda.nome == nome);
  }

  Sessione getSessioneCorrente(String nomeScheda, String nomeSessione) {
    return getSchedaCorrente(nomeScheda).sessioni.firstWhere((sessione) => sessione.nome == nomeSessione);
  }

  /* aggiungi sessione */
  void addSessione(String nomeScheda, String nomeSessione) {

    /* cerca la scheda corrente */
    Workout corrente =
    getSchedaCorrente(nomeScheda);

    /* aggiungi esercizio al workout corrente */
    corrente.sessioni.add(Sessione(nome: nomeSessione, esercizi: []));

    notifyListeners();
  }
}
