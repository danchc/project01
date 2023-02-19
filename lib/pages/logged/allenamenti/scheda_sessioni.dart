import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

  /* key form */
  final _formKey = GlobalKey<FormState>();

  //crea sessione
  void creaNuovaSessione() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Crea nuova sessione'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return '* Obbligatorio';
                }
                return null;
              },
              controller: sessioneController,
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
                    child: Text(
                      'Salva',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => salvaNuovaSessione(nome: sessioneController.text),
                ),
              ),
            ),
          ],
        ));
  }

  /* salva nuovo alimento */
  Future<void> salvaNuovaSessione({
    required String nome,
  }) async {
    if(_formKey.currentState!.validate()){

      DocumentReference documentReference =
      FirebaseFirestore.instance
          .collection('workout').doc(widget.nomeScheda)
              .collection('sessioni').doc(nome);

      Map<String, dynamic> data = <String, dynamic>{
        "id": nome,
        "nome": nome,
        "esercizi": [],
      };

      await documentReference
          .set(data)
          .whenComplete(() => print("Sessione ${nome} inserita.")).catchError((e) => print(e)); //log

      Navigator.pop(context);
      sessioneController.clear();
    }
  }

  Stream<QuerySnapshot> readItems() {
    CollectionReference collectionReference =
    FirebaseFirestore.instance
        .collection('workout').doc(widget.nomeScheda)
            .collection('sessioni');

    return collectionReference.snapshots();
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

       body: StreamBuilder<QuerySnapshot>(
         stream: readItems(),
         builder: (context, snapshot) {
           if (snapshot.hasError) {
             return Text('Error');
           } else if(snapshot.hasData || snapshot.data != null){

             return ListView.builder(
               shrinkWrap: true,
               scrollDirection: Axis.vertical,
               itemCount: snapshot.data!.docs.length,
               itemBuilder: (context,index) {

                 /* variabili */
                 var obj = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                 String nome = obj['nome'];


                 return Padding(
                   padding: EdgeInsets.all(20),
                   child:
                   ListTile(
                     title: Text(
                       nome,
                       style: const TextStyle(fontWeight: FontWeight.bold,
                           fontFamily: 'Barlow',
                           fontSize: 23),
                     ),
                     tileColor: Colors.white,
                     contentPadding: EdgeInsets.all(10),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius
                         .circular(10)),
                     trailing: IconButton(
                       icon: Icon(Icons.arrow_forward_ios),
                       onPressed: () =>
                       {
                         goInSchedaSessione(nome, widget.nomeScheda)
                       },
                     ),
                   ),
                 );
               }
             );
           } else if(snapshot.hasData && snapshot.data!.docs.length == 0) { //se non ci sono elementi
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
         onPressed: creaNuovaSessione,
         child: Icon(Icons.add),
       ),
    )
   );
  }
}
