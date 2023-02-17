import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:mcproject/pages/login_page.dart';
import '/components/my-textfield.dart';
import '/components/my-button.dart';
import 'package:material_dialogs/material_dialogs.dart';



class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  /* controllers */
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isVerified = false;

  void signUserUp() async {

    if(_formKey.currentState!.validate()){
      try {
        Dialogs.bottomMaterialDialog(
          context: context,
          color: Colors.white,
          msg: 'Controlla la tua e-mail!',
          title: 'E-mail di verifica inviata',
          lottieBuilder: Lottie.asset(
            'assets/animations/lottie1.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () {Navigator.pop(context);},
              text: 'Ricevuto',
              iconData: Icons.done,
              color: Colors.blue,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]
      );
      //provo a creare l'utente

        //controlliamo se le password corrispondono
        if(passwordController.text == passwordConfirmController.text) {

        UserCredential res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        User? user = res.user;
        user?.updateDisplayName(usernameController.text);

        if(FirebaseAuth.instance.currentUser?.emailVerified == false && FirebaseAuth.instance.currentUser != null) {
            sendVerificationEmail();
          }

        }
        else {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Le password non corrispondono'),
                  alignment: Alignment.center,
                );
              }
          );
        }
      } on FirebaseAuthException catch (e) {
        //se c'è qualche errore si toglie la schermata di caricamento
        //e mostra messaggio di errore
        Navigator.pop(context);
        showErrorMessage(e.code);
        log(e.code);
      }
    }

  }

  /* metodo per invio della e-mail di verifica */
  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Dialogs.bottomMaterialDialog(
          context: context,
          color: Colors.white,
          msg: 'Si è verificato un errore inaspettato',
          title: 'Errore!',
          lottieBuilder: Lottie.asset(
            'assets/animations/lottie2.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () {Navigator.pop(context);},
              text: 'Riprova',
              iconData: Icons.error_outline_sharp,
              color: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]
      );
    }

  }

  /* metodo per mostrare il popup di errore */
  void showErrorMessage(String errorCode) {

    if(errorCode == 'email-already-in-use'){
      Dialogs.bottomMaterialDialog(
          context: context,
          color: Colors.white,
          msg: 'L`e-mail è già in utilizzo.',
          title: 'Errore!',
          lottieBuilder: Lottie.asset(
            'assets/animations/lottie2.json',
            fit: BoxFit.contain,
          ),
          actions: [
            IconsButton(
              onPressed: () {Navigator.pop(context);},
              text: 'Riprova',
              iconData: Icons.error_outline_sharp,
              color: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Errore'),
              alignment: Alignment.center,
            );
          }
      );
    }
  }



  //final nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                //zona tasto back
                AppBar(
                  leading: const BackButton(
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.grey[300],
                  elevation: 0,
                ),

                const SizedBox(height: 30,),

                //testo principale
                const Text('Registrazione',
                  style:
                  TextStyle(
                    fontFamily: 'Barlow',
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20,),

                //testo secondario
                const Text('Inserisci i dati per essere dei nostri',
                  style:
                  TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 20,
                      color: Colors.black
                  ),
                ),

                //zona input
                Container(
                  child: Center(
                    child: Column(
                      children: [

                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              MyTextField(
                                  nome: 'Inserisci il tuo username',
                                  hide: false,
                                  controller: usernameController,
                                  error: 'Username non valido'
                              ),
                              const SizedBox(height: 20,),
                              MyTextField(
                                  nome: 'Inserisci la tua e-mail',
                                  hide: false,
                                  controller: emailController,
                                  error: 'E-mail non valida'
                              ),
                              const SizedBox(height: 20,),
                              MyTextField(
                                  nome: 'Inserisci la tua password',
                                  hide: true,
                                  controller: passwordController,
                                  error: 'Password non valida'
                              ),
                              const SizedBox(height: 20,),
                              MyTextField(
                                  nome: 'Conferma la tua password',
                                  hide: true,
                                  controller: passwordConfirmController,
                                  error: 'Password non valida'
                              ),
                              const SizedBox(height: 20,),
                            ],
                          ),
                        ),



                        //bottoni
                        MyButton(
                          name: 'Registrati',
                          onTap: signUserUp
                        ),

                        const SizedBox(height: 50,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Hai un account?',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                              ),
                            ),

                            GestureDetector(
                              onTap: () => {
                                Navigator.pop(context),

                                Navigator
                                .push(context,
                                    MaterialPageRoute(builder: (context) => LoginPage()))

                              },
                              child: const Text(
                                ' Accedi!',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Barlow',
                                ),
                              ),
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )

      ),
    );
  }
}
