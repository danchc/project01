import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mcproject/components/my-button.dart';
import 'package:mcproject/components/my-textfield.dart';
import 'package:mcproject/pages/logged/allenamenti.dart';

class AddAllenamento extends StatelessWidget {

  final controller;
  VoidCallback onSave;

  AddAllenamento({
    Key? key,
    required this.controller,
    required this.onSave
  }) : super(key: key);

  //colore principale
  static const _textColor = Color.fromARGB(255, 11, 49, 93);

  /* controller */
  final nomeSchedaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              AppBar(
                leading: const BackButton(
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey[300],
                elevation: 0,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: const DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Barlow',
                          color: _textColor,
                        ),
                        child: Text(
                        'Nuovo allenamento',
                       ),
                      ),
                    ),


                    const SizedBox(height: 15,),

                    Container(
                      width: double.infinity,
                      child: const DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18,
                          color: _textColor,
                        ),
                        child: Text(
                          'Stai aggiungendo una nuova scheda allenamento',
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              /* start zona input */
              const SizedBox(height: 25,),
              MyTextField(nome: 'Nome scheda', hide: false, controller: controller),

              /* fine zona input */
              const SizedBox(height: 25,),

              MyButton(
                  name: 'Aggiungi',
                  onTap: onSave,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
