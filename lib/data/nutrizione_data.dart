import 'package:flutter/cupertino.dart';
import 'package:mcproject/model/alimento.dart';

import '../model/alimentazione.dart';

/**
 * Operazioni base per gestire un elemento Alimentazione
 */

class NutrizioneData extends ChangeNotifier {

  /* lista default */
  List<Alimentazione> listaSchedeNutrizione = [];

  /* get lista di schede */
  List<Alimentazione> getSchedeNutrizioni() {
    return listaSchedeNutrizione;
  }

  /* get scheda corrente */
  Alimentazione getSchedaCorrente(String nome) {
    return listaSchedeNutrizione.firstWhere((scheda) => scheda.nome == nome);
  }

  /* add nuova scheda */
  void addSchedaNutrizione(String nome) {
    listaSchedeNutrizione.add(Alimentazione(nome: nome, alimenti: []));
    notifyListeners();
  }

  /* add nuovo alimento */
  void addNuovoAlimento(String nomeScheda, String nomeAlimento, String peso, String giorno) {

    /* prendo la scheda corrente */
    Alimentazione corrente = getSchedaCorrente(nomeScheda);

    /* aggiungo alimento alla lista nella scheda corrente */

    corrente.alimenti.add(
      Alimento(nome: nomeAlimento, peso: peso, giorno: giorno)
    );

  notifyListeners();
  }

  /* numero degli alimenti */
  int numeroAlimentiScheda(String nomeScheda) {

    /* prendo la scheda corrente */
    Alimentazione corrente = getSchedaCorrente(nomeScheda);

    return corrente.alimenti.length;
  }

}
