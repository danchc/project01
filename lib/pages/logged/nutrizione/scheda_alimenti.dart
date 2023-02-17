import 'package:flutter/material.dart';
import 'package:mcproject/components/my-scheda-alimento.dart';
import 'package:mcproject/data/nutrizione_data.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';

class SchedaAlimenti extends StatefulWidget {

  final String nomeScheda;

  const SchedaAlimenti({
    Key? key,
    required this.nomeScheda
  }) : super(key: key);

  @override
  State<SchedaAlimenti> createState() => _SchedaAlimentiState();
}

class _SchedaAlimentiState extends State<SchedaAlimenti> {

  /* controller */
  final nomeAlimentoController = TextEditingController();
  final pesoController = TextEditingController();
  final giornoController = TextEditingController();

  /* crea nuovo alimento */
  void creaNuovoAlimento() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi alimento'),
          content:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //input nome alimento
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: TextField(
                    controller: nomeAlimentoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome alimento'
                    ),
                  ),
                ),

                //input peso
                TextField(
                  controller: pesoController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Peso (gr)'
                  ),
                ),

                //input peso
                TextField(
                  controller: giornoController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Giorno della settimana'
                  ),
                ),

              ],
            ),

          actions: [
            Center(
              child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                    onPressed: salvaNuovoAlimento,
                    child: const Text(
                      'Salva',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    )
                ),
              ),
            ),
          ],
        ));
  }

  /* salva nuovo alimento */
  void salvaNuovoAlimento() {
    Provider.of<NutrizioneData>(context, listen:false).
      addNuovoAlimento(
        widget.nomeScheda,
        nomeAlimentoController.text,
        pesoController.text,
        giornoController.text,
    );
    Navigator.pop(context);
    clear();
  }

  void clear() {
    pesoController.clear();
    nomeAlimentoController.clear();
    giornoController.clear();
  }

  /* cancella alimento */
  void cancellaAlimento() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrizioneData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.nomeScheda,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const BackButton(
                color: Colors.black,
              ),
              backgroundColor: Colors.grey[300],
              elevation: 0,
            ),

            body:
            ListView.builder(
              itemCount: value.getSchedaCorrente(widget.nomeScheda).alimenti.length,
              itemBuilder: (context, index) {
                  return MySchedaAlimento(
                      nomeAlimento: value.getSchedaCorrente(widget.nomeScheda).alimenti[index].nome,
                      peso: value.getSchedaCorrente(widget.nomeScheda).alimenti[index].peso,
                      giornoDellaSettimana: value.getSchedaCorrente(widget.nomeScheda).alimenti[index].giorno,
                      deleteFunction: (context) => cancellaAlimento
                  );
              },
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: textColor,
              onPressed: creaNuovoAlimento,
              child: const Icon(Icons.add),
            ),

          ),

    );
  }
}
