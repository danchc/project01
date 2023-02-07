import 'package:flutter/material.dart';

class Nutrizione extends StatefulWidget {
  const Nutrizione({Key? key}) : super(key: key);

  @override
  State<Nutrizione> createState() => _NutrizioneState();
}

class _NutrizioneState extends State<Nutrizione> {
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
