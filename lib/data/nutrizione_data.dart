import 'package:flutter/cupertino.dart';
import 'package:mcproject/model/alimento.dart';

import '../model/nutrizione.dart';

/**
 * Operazioni base per gestire un elemento Nutrizione
 */

class NutrizioneData extends ChangeNotifier {

  /* lista default */
  List<Nutrizione> listaSchedeNutrizione = [];

  /* get lista di schede */
  List<Nutrizione> getSchedeNutrizioni() {
    return listaSchedeNutrizione;
  }

  /* get scheda corrente */
  Nutrizione getSchedaCorrente(String nome) {
    return listaSchedeNutrizione.firstWhere((scheda) => scheda.nome == nome);
  }

  /* add nuova scheda */
  void addSchedaNutrizione(String nome) {
    listaSchedeNutrizione.add(Nutrizione(nome: nome, alimenti: []));
    notifyListeners();
  }

  /* add nuovo alimento */
  void addNuovoAlimento(String nomeScheda, String nomeAlimento, String peso, String giorno) {

    /* prendo la scheda corrente */
    Nutrizione corrente = getSchedaCorrente(nomeScheda);

    /* aggiungo alimento alla lista nella scheda corrente */

    corrente.alimenti.add(
      Alimento(nome: nomeAlimento, peso: peso, giorno: giorno)
    );

  notifyListeners();
  }

  /* numero degli alimenti */
  int numeroAlimentiScheda(String nomeScheda) {

    /* prendo la scheda corrente */
    Nutrizione corrente = getSchedaCorrente(nomeScheda);

    return corrente.alimenti.length;
  }

}
