import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/pages/logged/home.dart';
import 'package:mcproject/pages/logged/home_page.dart';
import '/components/my-textfield.dart';
import '/components/my-button.dart';
import '/components/my-square-image.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn() async {
    //loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    log(emailController.text);
    log(passwordController.text);

    await FirebaseAuth
        .instance
        .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

    log('postauth');

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //colore sfondo
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,

      //corpo
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              //zona tasto indietro
              AppBar(
                leading: const BackButton(
                  color: Colors.black,
                ),
                backgroundColor: Colors.grey[300],
                elevation: 0,
              ),

              const SizedBox(height: 30),

              //testo iniziale
              const Text('Bentornato!',
                style:
                TextStyle(
                  fontFamily: 'Barlow',
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 80,),

              // zona input
              Container(
                child: Column(
                  children: [

                    //email input
                    MyTextField(nome: 'Inserisci la tua e-mail', hide: false, controller: emailController),

                    const SizedBox(height: 20,),

                    //password input
                    MyTextField(nome: 'Inserisci la tua password', hide: true, controller: passwordController),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                            'Hai dimenticato la password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Barlow',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    //bottone invio
                    MyButton(
                        name: 'Invio',
                        onTap: signIn
                    ),

                    const SizedBox(height: 50,),

                    //servizi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [

                        //google
                        SquareImage(image: 'assets/images/google.png'),

                        SizedBox(width:30),

                        //apple
                        SquareImage(image: 'assets/images/apple.png'),

                      ],
                    ),

                    const SizedBox(height: 70,),

                    //dicitura finale
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Non sei ancora un membro?',
                          style: TextStyle(
                            fontFamily: 'Barlow',
                          ),
                        ),

                        Text(
                          ' Registrati!',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Barlow',
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
