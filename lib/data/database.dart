import 'package:hive_flutter/hive_flutter.dart';

class BoxDatabase {

  List schedeAllenamento = [];

  //apriamo il box
  final _projectBox = Hive.box('project_box');

  //metodo per primo utilizzo
  void createInitialData() {
    schedeAllenamento = [
      'Scheda allenamento'
    ];
  }

  //carica i dati dal database
  void loadData() {
    schedeAllenamento = _projectBox.get("ALLENAMENTI");
  }

  //aggiorna i dati del database
  void updateDatabase() {
    _projectBox.put("ALLENAMENTI", schedeAllenamento);
  }
}
