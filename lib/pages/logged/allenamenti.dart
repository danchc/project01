import 'package:flutter/material.dart';

class Allenamenti extends StatefulWidget {
  const Allenamenti({Key? key}) : super(key: key);

  @override
  State<Allenamenti> createState() => _AllenamentiState();
}

class _AllenamentiState extends State<Allenamenti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],

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
