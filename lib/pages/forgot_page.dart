import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:mcproject/constants/constants.dart';

import '../components/my-textfield.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {

  /* controller */
  final emailController = TextEditingController();

  /* key per form */
  final _formKey = GlobalKey<FormState>();

  /* popup errore */
  void wrongMessage() {
    Dialogs.bottomMaterialDialog(
        context: context,
        color: Colors.white,
        msg: 'Qualcosa è andato storto',
        title: 'Errore!',
        lottieBuilder: Lottie.asset(
          'assets/animations/lottierr.json',
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

  /* metodo per gestire il ripristino della password */
  void forgotPassword(String email) async{
    if(_formKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Dialogs.bottomMaterialDialog(
            context: context,
            color: Colors.white,
            msg: 'Controlla la tua e-mail per ripristinare la password',
            title: 'E-mail inviata!',
            lottieBuilder: Lottie.asset(
              'assets/animations/lottie1.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () {Navigator.pop(context);},
                text: 'Ricevuto',
                iconData: Icons.done,
                color: Colors.blueAccent,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]
        );

      } on FirebaseException catch (e) {
        wrongMessage();
        log(e.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          centerTitle: true,
          title: Text('Recupera password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
          backgroundColor: Colors.grey[300],
          elevation: 0,
        ),

        body: Center(
          child: Container(
            height: 450,
            width: 400,
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 20,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 1,
                      color: Colors.grey[300]!)
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Recupera password',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 11, 49, 93)
                      )),

                  /* e-mail input */
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Required*';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 45,
                    width: 110,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      onPressed: () => {
                        forgotPassword(emailController.text)
                      },
                      child: const Text('Invia', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
