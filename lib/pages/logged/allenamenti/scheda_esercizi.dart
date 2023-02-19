import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mcproject/components/my-session.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:mcproject/model/esercizio.dart';
import 'package:provider/provider.dart';

import '../../../data/workout_data.dart';

class SchedaEsercizi extends StatefulWidget {

  final String nomeSessione;
  final String nomeScheda;

  const SchedaEsercizi({
    Key? key,
    required this.nomeSessione,
    required this.nomeScheda,
  }) : super(key: key);

  @override
  State<SchedaEsercizi> createState() => _SchedaEserciziState();
}

class _SchedaEserciziState extends State<SchedaEsercizi> {

  /* controllers */
  final nomeEsercizioController = TextEditingController();
  final numeroSetsController = TextEditingController();
  final numeroRepsController = TextEditingController();
  final pesoController = TextEditingController();

  /* key form */
  final _formKey = GlobalKey<FormState>();


  //crea nuovo esercizio
  void aggiungiEsercizio() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi esercizio'),

          //input nome esercizio
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return '* Obbligatorio';
                            }
                            return null;
                          },
                          controller: nomeEsercizioController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Nome esercizio'
                          ),
                        ),
                      ),

                      //input numero sets
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return '* Obbligatorio';
                            }
                            return null;
                          },
                          controller: numeroSetsController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Numero set'
                          ),
                        ),
                      ),

                      //input numero reps
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return '* Obbligatorio';
                            }
                            return null;
                          },
                          controller: numeroRepsController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Numero reps'
                          ),
                        ),
                      ),

                      //input peso
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return '* Obbligatorio';
                          }
                          return null;
                        },
                        controller: pesoController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Peso (KG)'
                        ),
                      ),
                    ],
                  )

              )
              //input nome esercizio

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
                    child: Text(
                      'Salva',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => salvaNuovoEsercizio(
                        nome: nomeEsercizioController.text,
                        reps: numeroRepsController.text,
                        sets: numeroSetsController.text,
                        peso: pesoController.text)
                ),
              ),
            ),
          ],
        ));

  }

  /* salva nuovo alimento */
  Future<void> salvaNuovoEsercizio({
    required String nome,
    required String reps,
    required String sets,
    required String peso
  }) async {
    if(_formKey.currentState!.validate()){

      DocumentReference documentReference =
      FirebaseFirestore.instance
          .collection('workout').doc(widget.nomeScheda)
          .collection('sessioni').doc(widget.nomeSessione)
          .collection('esercizi').doc(nome);

      Map<String, dynamic> data = <String, dynamic>{
        "id": nome,
        "nome": nome,
        "reps": reps,
        "sets": sets,
        "peso": peso
      };

      await documentReference
          .set(data)
          .whenComplete(() => print("Esercizio ${nome} inserito.")).catchError((e) => print(e)); //log

      Navigator.pop(context);
      clear();
    }
  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference collectionReference =
    FirebaseFirestore.instance
        .collection('workout').doc(widget.nomeScheda)
        .collection('sessioni').doc(widget.nomeSessione)
        .collection('esercizi');

    return collectionReference.snapshots();
  }

  //elimina esercizio
  void deleteEsercizio(int index) {

  }

  //metodo per effettuare un clear dei controller
  void clear() {
    nomeEsercizioController.clear();
    numeroRepsController.clear();
    numeroSetsController.clear();
    pesoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllenamentiData>(
      builder: (context, value, child) =>
          Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              centerTitle: true,
              title: Text(widget.nomeSessione,
                style: TextStyle(
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
            StreamBuilder<QuerySnapshot>(
              stream: readItems(),
              builder: (context, snapshot) {

                if (snapshot.hasError) {
                  return Text('Error');
                } else if(snapshot.hasData || snapshot.data != null){

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      /* variabili */
                      var obj = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      String nome = obj['nome'];
                      String reps = obj['reps'];
                      String sets = obj['sets'];
                      String peso = obj['peso'];


                      return MySessione(
                        nomeEsercizio: nome,
                        sets: sets,
                        reps: reps,
                        peso: peso,
                        deleteFunction: (context) => deleteEsercizio,
                      );
                    },
                  );

                } else if(snapshot.hasData && snapshot.data!.docs.length == 0) {
                  //se non ci sono elementi
                  return Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: Center(
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/images/void.svg',height: 170,),

                          const Text(
                            'Sembra non ci sia niente',
                            style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else {

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: textColor,
              onPressed: aggiungiEsercizio,
              child: Icon(Icons.add),
            ),
          ),
    );
  }
}
