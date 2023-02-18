import 'package:hive_flutter/hive_flutter.dart';

class BoxDatabase {

  List schedeAllenamento = [];

  //apriamo il box
  final box = Hive.box('workact_box');

  //metodo per primo utilizzo
  void createInitialData() {
    schedeAllenamento = [
      'Scheda allenamento'
    ];
  }

  //carica i dati dal database
  void loadData() {
    schedeAllenamento = box.get("ALLENAMENTI");
  }

  //aggiorna i dati del database
  void updateDatabase() {
    box.put("ALLENAMENTI", schedeAllenamento);
  }
}
