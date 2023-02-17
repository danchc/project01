import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
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
            Center(
              child: Material(
                color: Colors.black,
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                elevation: 18.0,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  onPressed: saveNuovaScheda,
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
                  ],

                ]
              ),
            ),
          ),
        ),


      ),
    );


  }
}
