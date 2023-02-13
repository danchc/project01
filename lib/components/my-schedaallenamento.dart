import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MySchedaAllenamento extends StatelessWidget {

  final String nomeScheda;
  final IconData? icona;
  Function(BuildContext)? deleteFunction;

  MySchedaAllenamento({
    Key? key,
    required this.nomeScheda,
    required this.icona,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
          padding: const EdgeInsets.all(15.0),
          child:
          Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete_forever_rounded,
                  backgroundColor: Colors.redAccent,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              ),
              height: 80,
              width: 500,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 14.0),
                    child:

                    //icona principale
                    Icon(
                        icona,
                        size: 34,
                      ),
                  ),

                    //testo principale
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0,vertical: 15),
                      child: Text(
                        nomeScheda,
                        style: const TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    //freccia finale
                    const Padding(
                      padding: EdgeInsets.only(left: 250.0),
                      child: Icon(
                        Icons.chevron_left,
                        size: 22,
                      ),
                    )
                ],
              ),
            ),
          ),
       );
    }
}
