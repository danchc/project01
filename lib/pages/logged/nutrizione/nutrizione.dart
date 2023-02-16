import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/nutrizione_data.dart';
import 'package:mcproject/pages/logged/nutrizione/scheda_alimenti.dart';
import 'package:provider/provider.dart';

import '../../../components/my-schedaallenamento.dart';

class Nutrizione extends StatefulWidget {

  const Nutrizione({
    Key? key
  }) : super(key: key);

  @override
  State<Nutrizione> createState() => _NutrizioneState();
}

class _NutrizioneState extends State<Nutrizione> {
  /* controller principale */
  final schedaNutrizioneController = TextEditingController();

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi nuova scheda'),
          content: TextField(
            controller: schedaNutrizioneController,
          ),
          actions: [
            MaterialButton(
              child: Text('Salva'),
              onPressed: saveScheda,
            ),
          ],
        ));

    schedaNutrizioneController.clear();
  }

  /* delete scheda */
  void deleteScheda(int index) {}

  /* save scheda */
  void saveScheda() {
    Provider.of<NutrizioneData>(context, listen:false).addSchedaNutrizione(schedaNutrizioneController.text);
    Navigator.pop(context);
    schedaNutrizioneController.clear();
  }

  @override
  Widget build(BuildContext context) {
     return Consumer<NutrizioneData>(
       builder: (context,value,child) =>
       Scaffold(
         backgroundColor: Colors.grey[200],
         appBar: AppBar(
           title: const Text(
               'Nutrizione',
             style: TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.bold, fontSize: 24)
           ),
           automaticallyImplyLeading: false,
           centerTitle: true,
           backgroundColor: colore,
         ),


         body: ListView.builder(
             itemCount: value.getSchedeNutrizioni().length,
             itemBuilder: (context,index) {
               // singola scheda
               return GestureDetector(
                 onTap: () => {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SchedaAlimenti(nomeScheda: value.getSchedeNutrizioni()[index].nome,)))
                 },
                 child: MySchedaAllenamento(
                   nomeScheda: value.getSchedeNutrizioni()[index].nome,
                   icona: LineIcons.beer,
                   deleteFunction: (context) => deleteScheda(index),
                 ),
               );
             }
         ),

         floatingActionButton: FloatingActionButton(
           backgroundColor: textColor,
           onPressed: createNuovaScheda,
           child: Icon(Icons.add),
         ),
       ),
     );
  }
}
