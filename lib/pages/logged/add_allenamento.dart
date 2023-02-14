import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcproject/components/my-button.dart';
import 'package:mcproject/components/my-numberfield.dart';
import 'package:mcproject/components/my-textfield.dart';
import 'package:mcproject/pages/logged/allenamenti.dart';


class AddAllenamento extends StatelessWidget {

  final controller;
  final numContr;
  VoidCallback onSave;

  AddAllenamento({
    Key? key,
    required this.controller,
    required this.numContr,
    required this.onSave,
  }) : super(key: key);

  //colore principale
  static const _textColor = Color.fromARGB(255, 11, 49, 93);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
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


            Form(
              child: Column(
                children: [

                  /* start zona input */
                  const SizedBox(height: 25,),
                  MyTextField(
                    nome: 'Nome scheda',
                    hide: false,
                    controller: controller,
                    error: 'Nome non valido',
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
                    child: Container(
                      width: double.infinity,
                      child: const DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 18,
                          color: _textColor,
                        ),
                        child: Text(
                          'Quanti giorni ti alleni?',
                        ),
                      ),
                    ),
                  ),



                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Numero non valido';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^[1-6]$|^7$'),
                          ),
                        ],
                        keyboardType: TextInputType.number,
                        controller: numContr,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Inserisci il numero di giorni',
                        ),
                      ),
                    ),
                  ),

                  /* fine zona input */
                  const SizedBox(height: 25,),
                ],
              ),
            ),

            MyButton(
                name: 'Aggiungi',
                onTap: onSave,
            ),


          ],
        ),
      ),
    );
  }
}
