import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:mcproject/components/my-schedaallenamento.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:mcproject/pages/logged/add_allenamento.dart';
import 'package:mcproject/pages/logged/allenamenti/scheda_sessioni.dart';
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

  /* key form */
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  //funzione che riporta alla scheda per aggiungere scheda
  void createNuovaScheda() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Aggiungi nuova scheda'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return '* Obbligatorio';
                }
                return null;
              },
              controller: _controller,
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
                  onPressed: () => salvaNuovoWorkout(nome: _controller.text),
                  child: const Text(
                    'Salva',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ));

    _controller.clear();
  }

  /* salva nuovo alimento */
  Future<void> salvaNuovoWorkout({
    required String nome,
  }) async {
    if(_formKey.currentState!.validate()){

      DocumentReference documentReference =
      FirebaseFirestore.instance.collection('workout').doc(_controller.text);

      Map<String, dynamic> data = <String, dynamic>{
        "id": nome,
        "nome": nome,
        "sessioni": [],
      };

      await documentReference
          .set(data)
          .whenComplete(() => print("Workout ${nome} inserito.")).catchError((e) => print(e)); //log

      Navigator.pop(context);
      _controller.clear();
    }
  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference collectionReference =
    FirebaseFirestore.instance
        .collection('workout');

    return collectionReference.snapshots();
  }

  bool test = true;

  void readInt() async {
    var mainCollection = await FirebaseFirestore.instance.collection('workout').get();
    final int count = mainCollection.size;
  }

  //funzione per eliminare scheda
  static Future<void> deleteScheda({
      required String docId,
    }) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('workout').doc(docId);

    await documentReference
      .delete().whenComplete(() => print('Workout ${docId} eliminato con successo.')).catchError((e) => print(e));

  }

  //funzione per andare alla prossima scheda
  void goInSchedaAllenamenti(String nomeAllenamento) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SchedaAllenamento(nomeScheda: nomeAllenamento)));
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
    return Consumer<AllenamentiData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Center(
            child: SafeArea(
              child: Column(
                  children: [

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
                                          LineIcons.running,
                                          size: 50,
                                          color: textColor,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          child: Text(
                                            'Allenamenti',
                                            style: TextStyle(
                                                color: textColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                fontFamily: 'Barlow'
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  //
                                  FloatingActionButton(
                                    backgroundColor: textColor,
                                    onPressed: createNuovaScheda,
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  'Le tue schede allenamento',
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontFamily: 'Barlow'
                                  ),
                                ),
                              ),
                            ],
                          )

                      ),
                    ),

                    /*
                    if(value.listaSchede.isEmpty) ... [
                      Container(
                        margin: const EdgeInsets.only(top: 80),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                      )
                    ]
                    else ... [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: value.listaSchede.length,
                          itemBuilder: (context,index) {
                            // singola scheda
                            return GestureDetector(
                              onTap: () => {
                                goInSchedaAllenamenti(value.getListaSchede()[index].nome)
                              },
                              child:

                              MySchedaAllenamento(
                                nomeScheda: value.getListaSchede()[index].nome,
                                icona: LineIcons.dumbbell,
                                deleteFunction: (context) => deleteScheda(index),
                              ),
                            );
                          }
                      ),
                    ],*/

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
                                          MaterialPageRoute(builder: (context) => SchedaAllenamento(nomeScheda: nome)))
                                    },
                                    child: MySchedaAllenamento(
                                      nomeScheda: nome,
                                      icona: LineIcons.dumbbell,
                                      deleteFunction: (context) async {
                                        warningMessage(nome);
                                      }
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



                  ]
              ),
            ),
          ),
        ),


      ),
    );


  }
}
