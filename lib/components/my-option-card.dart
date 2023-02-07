import 'package:flutter/material.dart';

class MyOptionCard extends StatelessWidget {

  /* parametri */
  final String descrizione;
  final IconData? icona;

  const MyOptionCard({Key? key, required this.descrizione, required this.icona}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                  icona,
                size: 27,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 88.0),
              child: Container(
                width: 200,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  descrizione,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            Icon(
                Icons.arrow_forward_ios,
              size: 18,
            ),

          ],
        ),
      ),
    );
  }
}
