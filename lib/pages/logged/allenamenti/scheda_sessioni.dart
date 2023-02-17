import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:mcproject/pages/logged/allenamenti/scheda_esercizi.dart';
import 'package:provider/provider.dart';

import '../../../data/workout_data.dart';

class SchedaAllenamento extends StatefulWidget {

  final String nomeScheda;

  const SchedaAllenamento({
    Key? key,
    required this.nomeScheda,
  }) : super(key: key);

  @override
  State<SchedaAllenamento> createState() => _SchedaAllenamentoState();
}

class _SchedaAllenamentoState extends State<SchedaAllenamento> {

  //controller della sessione
  final sessioneController = TextEditingController();


  //aggiungiamo una nuova sessione alla lista
  void salvaSessione() {
    Provider.of<AllenamentiData>(context, listen: false).addSessione(widget.nomeScheda, sessioneController.text);
    Navigator.pop(context);
    clear();
  }

  //crea sessione
  void creaNuovaSessione() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Crea nuova sessione'),
          content: TextField(
            controller: sessioneController,
          ),
          actions: [
            Center(
              child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                    child: Text(
                      'Salva',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: salvaSessione
                ),
              ),
            ),
          ],
        ));
  }

  //metodo per entrare nei dettagli della scheda selezionata
  void goInSchedaSessione(String nomeSessione, String nomeScheda) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SchedaEsercizi(nomeSessione: nomeSessione, nomeScheda: nomeScheda)));
  }

  //metodo per fare un clear dei controller
  void clear() {
    sessioneController.clear();
  }

  @override
  Widget build(BuildContext context) {
   return Consumer<AllenamentiData>(
     builder: (context, value, child) =>
     Scaffold(
       backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
              widget.nomeScheda,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),

       body: ListView.builder(
         itemCount: value.getSchedaCorrente(widget.nomeScheda).sessioni.length,
         itemBuilder: (context,index) =>
          Padding(
            padding: EdgeInsets.all(20),
            child :
            ListTile(
              title: Text(
                  value.getSchedaCorrente(widget.nomeScheda).sessioni[index].nome,
                style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Barlow'),
              ),
              tileColor: Colors.white,
              contentPadding: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () => {
                 goInSchedaSessione(value.getSchedaCorrente(widget.nomeScheda).sessioni[index].nome, widget.nomeScheda)
                },
              ),
            ),
          ),
       ),

       floatingActionButton: FloatingActionButton(
         backgroundColor: textColor,
         onPressed: creaNuovaSessione,
         child: Icon(Icons.add),
       ),
    )
   );
  }
}
