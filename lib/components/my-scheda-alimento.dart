import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants/constants.dart';

class MySchedaAlimento extends StatelessWidget {

  final String nomeAlimento;
  final String peso;
  final String giornoDellaSettimana;
  Function(BuildContext)? deleteFunction;

  MySchedaAlimento({
    Key? key,
    required this.nomeAlimento,
    required this.peso,
    required this.giornoDellaSettimana,
    required this.deleteFunction
  }) : super(key: key);

  Color coloreChip = greenColor;

  Color getColore(String giorno) {
    if(giorno == 'lunedi' || giorno == 'lunedì') {
      coloreChip = Colors.blueAccent;
    } else if(giorno == 'martedi' || giorno == 'martedì') {
      coloreChip = Colors.deepOrangeAccent;
    } else if(giorno == 'mercoledi' || giorno == 'mercoledì') {
      coloreChip = Colors.redAccent;
    } else if(giorno == 'giovedi' || giorno == 'giovedì') {
      coloreChip = Colors.deepPurpleAccent;
    } else if(giorno == 'venerdi' || giorno == 'venerdì') {
      coloreChip = Colors.green;
    } else if(giorno == 'sabato') {
      coloreChip = Colors.yellow;
    } else if(giorno == 'domenica') {
      coloreChip = Colors.pinkAccent;
    }

    return coloreChip;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_forever_rounded,
              backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              child: Column(
                children: [
                  Text(
                    nomeAlimento,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: 'Barlow',
                      color: textColor,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Chip(
                        label: Text(
                          "$peso gr",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Barlow',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: greenColor,
                      ),

                      Chip(
                        label: Text(
                          giornoDellaSettimana,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Barlow',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: getColore(giornoDellaSettimana.toLowerCase()),
                      ),

                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
