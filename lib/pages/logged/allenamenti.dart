import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/components/my-schedaallenamento.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/database.dart';
import 'package:mcproject/pages/logged/add_allenamento.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mcproject/pages/logged/scheda_allenamento.dart';


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
  final _numController = TextEditingController();

  //lista
  List schedeAllenamento = [];

  @override
  void initState() {

    super.initState();
  }



  //salva nuova scheda
  void saveNuovaScheda() {
    setState(() {
      schedeAllenamento.add(_controller.text);
    });
    Navigator.of(context).pop();
    _numController.clear();
    log('Numero: ${_numController.text}');
  }

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(context: context, builder: (context) {
      return AddAllenamento(
          controller: _controller,
          numContr: _numController,
          onSave: saveNuovaScheda,
      );});

  }

  //funzione per eliminare scheda
  void deleteScheda(int index) {
    setState(() {
      schedeAllenamento.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
            'Allenamenti'
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: colore,
      ),


      body: ListView.builder(
          itemCount: schedeAllenamento.length,
          itemBuilder: (context,index) {
            // singola scheda
            return GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SchedaAllenamento(nomeScheda: schedeAllenamento[index].toString())
                    ))
              },
              child: MySchedaAllenamento(
                  nomeScheda: schedeAllenamento[index].toString(),
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
    );


  }
}
