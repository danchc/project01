import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants/constants.dart';

class MySessione extends StatelessWidget {

  //colore principale
  static const color = Color(0xff2b8efd);

  final String nomeEsercizio;
  final String sets;
  final String reps;
  final String peso;
  Function(BuildContext)? deleteFunction;

  MySessione({
    Key? key,
    required this.deleteFunction,
    required this.nomeEsercizio,
    required this.sets,
    required this.reps,
    required this.peso
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
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
                    nomeEsercizio,
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
                          "${sets} SETS",
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Barlow',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: color,
                      ),

                      Chip(
                        label: Text(
                          '${reps} REPS',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Barlow',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: color,
                      ),

                      Chip(
                        label: Text(
                          '${peso} KG',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Barlow',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: color,
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
