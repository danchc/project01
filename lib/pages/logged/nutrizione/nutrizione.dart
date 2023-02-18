/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  /* key form */
  final _formKey = GlobalKey<FormState>();

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Aggiungi nuova scheda'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return '* Obbligatorio';
                }
                return null;
              },
              controller: schedaNutrizioneController,
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
                  onPressed: saveScheda,
                  child: const Text(
                    'Salva',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ));

    schedaNutrizioneController.clear();
  }

  /* delete scheda */
  void deleteScheda(int index) {}

  /* save scheda */
  void saveScheda() {
    if(_formKey.currentState!.validate()) {
      Provider.of<NutrizioneData>(context, listen:false).addSchedaNutrizione(schedaNutrizioneController.text);
      Navigator.pop(context);
      schedaNutrizioneController.clear();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrizioneData>(
      builder: (context,value,child) =>
          Scaffold(
            backgroundColor: Colors.grey[200],

            body: SingleChildScrollView(
              child: Center(
                child: SafeArea(
                  child: Column(
                    children: [

                      /* header della pagina */
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            LineIcons.hamburger,
                                            size: 50,
                                            color: greenColor,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(
                                              'Alimentazione',
                                              style: TextStyle(
                                                  color: greenColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  fontFamily: 'Barlow'
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    /* floating button */
                                    FloatingActionButton(
                                      backgroundColor: greenColor,
                                      onPressed: createNuovaScheda,
                                      child: Icon(Icons.add),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),

                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'Le tue schede alimentazione',
                                    style: TextStyle(
                                        color: greenColor,
                                        fontSize: 20,
                                        fontFamily: 'Barlow'
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),

                      if (value.listaSchedeNutrizione.isEmpty) ... [
                        Container(
                          margin: const EdgeInsets.only(top: 80),
                          child: Center(
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/images/void1.svg',height: 170,),

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
                        )
                      ]
                      else ...[
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
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
                      ],
                      /* lista delle schede */

                    ],
                  ),
                ),
              ),
            ),

          ),
    );
  }
}*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  /* key form */
  final _formKey = GlobalKey<FormState>();

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Aggiungi nuova scheda'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return '* Obbligatorio';
                }
                return null;
              },
              controller: schedaNutrizioneController,
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
                  onPressed: () => saveScheda(nome: schedaNutrizioneController.text),
                  child: const Text(
                    'Salva',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ));

    schedaNutrizioneController.clear();
  }

  /* delete scheda */
  void deleteScheda(int index) {}

  /* save scheda */
  Future<void> saveScheda({
    required String nome
  }) async{
    if(_formKey.currentState!.validate()) {
      DocumentReference documentReference =
        FirebaseFirestore.instance.collection('nutrizione').doc(nome);

      Map<String, dynamic> data = <String, dynamic>{
        "id": nome,
        "nome": nome,
        "alimenti": []
      };

      await documentReference.set(data);

      Navigator.pop(context);
      schedaNutrizioneController.clear();
    }

  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('nutrizione');

    return collectionReference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NutrizioneData>(
      builder: (context,value,child) =>
          Scaffold(
            backgroundColor: Colors.grey[200],

            body: SingleChildScrollView(
              child: Center(
                child: SafeArea(
                  child: Column(
                    children: [

                      /* header della pagina */
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                        child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            LineIcons.hamburger,
                                            size: 50,
                                            color: greenColor,
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 5.0),
                                          child: Container(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(
                                              'Alimentazione',
                                              style: TextStyle(
                                                  color: greenColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                  fontFamily: 'Barlow'
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    /* floating button */
                                    FloatingActionButton(
                                      backgroundColor: greenColor,
                                      onPressed: createNuovaScheda,
                                      child: Icon(Icons.add),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),

                                Container(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    'Le tue schede alimentazione',
                                    style: TextStyle(
                                        color: greenColor,
                                        fontSize: 20,
                                        fontFamily: 'Barlow'
                                    ),
                                  ),
                                ),
                              ],
                            )

                        ),
                      ),

                        StreamBuilder<QuerySnapshot>(
                          stream: readItems(),
                          builder: (context, snapshot) {

                            if (snapshot.hasError) {
                              return Text('Error');
                            } else if(snapshot.hasData || snapshot.data != null){
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context,index) {

                                    var obj = snapshot.data!.docs[index].data() as Map<String,dynamic>;
                                    String nome = obj['nome'];

                                    // singola scheda
                                    return GestureDetector(
                                      onTap: () => {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => SchedaAlimenti(nomeScheda: nome,)))
                                      },
                                      child: MySchedaAllenamento(
                                        nomeScheda: nome,
                                        icona: LineIcons.beer,
                                        deleteFunction: (context) => deleteScheda(index),
                                      ),
                                    );
                                  }
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                          }

                        ),
                      ],
                      /* lista delle schede */

                  ),
                ),
              ),
            ),

          ),
    );
  }
}

