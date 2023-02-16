import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/components/my-schedaallenamento.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:mcproject/pages/logged/add_allenamento.dart';
import 'package:mcproject/pages/logged/scheda_sessioni.dart';
import 'package:provider/provider.dart';


class Allenamenti extends StatefulWidget {

  const Allenamenti({
    Key? key,
  }) : super(key: key);

  @override
  State<Allenamenti> createState() => _AllenamentiState();
}

class _AllenamentiState extends State<Allenamenti> {


  //controller
  final  _controller = TextEditingController();

  //lista
  List schedeAllenamento = [];

  @override
  void initState() {

    super.initState();
  }



  /*
  //salva nuova scheda
  void saveNuovaScheda() {
    setState(() {
      schedeAllenamento.add(_controller.text);
    });
    Navigator.of(context).pop();
    _numController.clear();
  }*/

  void saveNuovaScheda() {
    Provider.of<AllenamentiData>(context, listen: false).addScheda(_controller.text);
    Navigator.pop(context);
  }

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi nuova scheda'),
          content: TextField(
            controller: _controller,
          ),
          actions: [
            MaterialButton(
                child: Text('Salva'),
                onPressed: saveNuovaScheda,
            ),
          ],
        ));

    _controller.clear();
  }

  //funzione per eliminare scheda
  void deleteScheda(int index) {
    setState(() {
      schedeAllenamento.removeAt(index);
    });
  }

  //funzione per andare alla prossima scheda
  void goInSchedaAllenamenti(String nomeAllenamento) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SchedaAllenamento(nomeScheda: nomeAllenamento)));
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AllenamentiData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text(
              'Allenamenti',
              style: TextStyle(fontFamily: 'Barlow', fontWeight: FontWeight.bold, fontSize: 24)
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: colore,
        ),


        body: ListView.builder(
            itemCount: value.listaSchede.length,
            itemBuilder: (context,index) {
              // singola scheda
              return GestureDetector(
                onTap: () => {
                  goInSchedaAllenamenti(value.getListaSchede()[index].nome)
                },
                child: MySchedaAllenamento(
                    nomeScheda: value.getListaSchede()[index].nome,
                    icona: LineIcons.dumbbell,
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
