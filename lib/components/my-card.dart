import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {

  final String descrizione;
  final Color? colore;

  const MyCard({Key? key, required this.descrizione, required this.colore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colore,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0,1)
        )],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          descrizione,
          style: const TextStyle(
            fontFamily: 'Barlow',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
