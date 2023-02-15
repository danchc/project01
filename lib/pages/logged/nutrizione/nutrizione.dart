import 'package:flutter/material.dart';
import 'package:mcproject/constants/constants.dart';

class Nutrizione extends StatefulWidget {
  const Nutrizione({Key? key}) : super(key: key);

  @override
  State<Nutrizione> createState() => _NutrizioneState();
}

class _NutrizioneState extends State<Nutrizione> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text(
             'Nutrizione'
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: colore,
      ),
       body: SafeArea(
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [


               Text(
                 'Non ci sono schede nutrizione',
                 style: TextStyle(
                   fontSize: 15,
                 ),
               )
             ],
           ),
         ),
       ),
    );
  }
}
