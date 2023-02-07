import 'package:flutter/material.dart';
import 'package:mcproject/constants/constants.dart';

class Allenamenti extends StatefulWidget {
  const Allenamenti({Key? key}) : super(key: key);

  @override
  State<Allenamenti> createState() => _AllenamentiState();
}

class _AllenamentiState extends State<Allenamenti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Allenamenti'
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: colore,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );


  }
}
