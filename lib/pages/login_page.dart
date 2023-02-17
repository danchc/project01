import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/pages/logged/home.dart';
import 'package:mcproject/pages/logged/home_page.dart';
import 'package:mcproject/pages/register_page.dart';
import '/components/my-textfield.dart';
import '/components/my-button.dart';
import '/components/my-square-image.dart';
import 'package:mcproject/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static String id = "sign_in";

  /* controllers */
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  /* metodo per il login */
  void signIn() async {
    if(_formKey.currentState!.validate()){
      //loading
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      );

      Navigator.of(context).pop();
      Navigator.of(context).pop();
      //prova a controllare se le credenziali sono corrette
      try {
        await FirebaseAuth
            .instance
            .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        /* controllo dati utente */
       log(FirebaseAuth.instance.currentUser!.emailVerified.toString());
        log(FirebaseAuth.instance.currentUser!.displayName.toString());
        log(FirebaseAuth.instance.currentUser!.email.toString());
        log(FirebaseAuth.instance.currentUser!.photoURL.toString());
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if(e.code == 'user-not-found') {
          wrongEmailMessage();
        } else if(e.code == 'wrong-password') {
          wrongPasswordMessage();
        } else {
          /*
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Errore'),
              );
            }
        ); */
        }
      }
    }
  }

  /* metodo per mostrare il messaggio di errore dell'email */
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('E-mail o password non corretti'),
            alignment: Alignment.center,
          );
        }
    );
  }

  /* metodo per mostrare il messaggio di errore della password */
  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('E-mail o password non corretta'),
            alignment: Alignment.center,
          );
        }
    );
  }

  /* metodo per gestire il login con google */
  void googleSignIn() async {
    AuthService().googleSignIn();
    Navigator.of(context).pop(id);
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
          child: SingleChildScrollView(
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

                      Form(
                        key: _formKey,
                          child: Column(
                            children: [
                              MyTextField(
                                nome: 'Inserisci la tua e-mail',
                                hide: false,
                                controller: emailController,
                                error: 'E-mail non valida',
                              ),

                              const SizedBox(height: 20,),

                              //password input
                              MyTextField(
                                  nome: 'Inserisci la tua password',
                                  hide: true,
                                  controller: passwordController,
                                  error: 'Password non valida'
                              ),
                            ]
                          ),
                      ),
                      //email input


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
                        children: [

                          //google
                          SquareImage(
                              image: 'assets/images/google.png',
                              onTap: googleSignIn,
                          ),

                          const SizedBox(width:30),

                          //apple
                          SquareImage(
                              image: 'assets/images/apple.png',
                              onTap: () => {},
                          ),

                        ],
                      ),

                      const SizedBox(height: 70,),

                      //dicitura finale
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Non sei ancora un membro?',
                            style: TextStyle(
                              fontFamily: 'Barlow',
                            ),
                          ),

                          GestureDetector(
                            onTap: () => {
                              Navigator.pop(context),

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => RegisterPage()))
                            },
                            child: const Text(
                              ' Registrati!',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Barlow',
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
