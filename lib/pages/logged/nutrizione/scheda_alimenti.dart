import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
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

  /* key form */
  final _formKey = GlobalKey<FormState>();

  /* crea nuovo alimento */
  void creaNuovoAlimento() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi alimento'),
          content:
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    controller: nomeAlimentoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nome alimento'
                    ),
                  ),
                ),

                //input peso
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return '* Obbligatorio';
                      }
                      return null;
                    },
                    controller: pesoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Peso (gr)'
                    ),
                  ),
                ),

                //input peso
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return '* Obbligatorio';
                      }
                      return null;
                    },
                    controller: giornoController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Giorno della settimana'
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            Center(
              child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                    onPressed: () => salvaNuovoAlimento(
                      nome: nomeAlimentoController.text,
                      peso: pesoController.text,
                      giorno: giornoController.text
                    ),
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
  Future<void> salvaNuovoAlimento({
    required String nome,
    required String peso,
    required String giorno,
    }) async {
    if(_formKey.currentState!.validate()){

      DocumentReference documentReference =
        FirebaseFirestore.instance.collection('nutrizione').doc(widget.nomeScheda).collection('alimento').doc(nome);

      Map<String, dynamic> data = <String, dynamic>{
        "id": nome,
        "nome": nome,
        "peso": peso,
        "giorno": giorno
      };

      await documentReference
          .set(data)
          .whenComplete(() => print("Alimento ${nome} inserito.")).catchError((e) => print(e)); //log

      Navigator.pop(context);
      clear();
    }
  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance
            .collection('nutrizione').doc(widget.nomeScheda)
            .collection('alimento');

    return collectionReference.snapshots();
  }

  //funzione per eliminare scheda
  Future<void> deleteScheda({
    required String docId,
  }) async {
    log('sono qui 1');
    DocumentReference documentReference =
    await FirebaseFirestore.instance.collection('nutrizione').doc(widget.nomeScheda)
    .collection('alimento').doc(docId);

    await documentReference
        .delete().whenComplete(() => print('Alimento ${docId} eliminato con successo.')).catchError((e) => print(e));
  }


  void clear() {
    pesoController.clear();
    nomeAlimentoController.clear();
    giornoController.clear();
  }

  void warningMessage(String docId) {
    Dialogs.bottomMaterialDialog(
        context: context,
        color: Colors.white,
        msg: 'Sei sicuro di voler eliminare questo elemento?',
        title: 'Attenzione!',
        lottieBuilder: Lottie.asset(
          'assets/animations/warning.json',
          fit: BoxFit.contain,
        ),
        actions: [
          IconsButton(
            onPressed: () {
              deleteScheda(docId: docId);
              Navigator.pop(context);
              },
            text: 'Sono sicuro',
            iconData: Icons.error_outline_sharp,
            color: Colors.yellow,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]
    );
  }



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
            StreamBuilder<QuerySnapshot>(
              stream: readItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                } else if(snapshot.hasData || snapshot.data != null){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      /* variabili */
                      var obj = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      String nome = obj['nome'];
                      String peso = obj['peso'];
                      String giorno = obj['giorno'];

                      return MySchedaAlimento(
                          nomeAlimento: nome,
                          peso: peso,
                          giornoDellaSettimana: giorno,
                          deleteFunction: (context) async {
                            warningMessage(nome);
                          }
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }

            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: greenColor,
              onPressed: creaNuovoAlimento,
              child: const Icon(Icons.add),
            ),

          ),

    );
  }
}
