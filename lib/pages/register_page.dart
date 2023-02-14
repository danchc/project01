import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcproject/pages/login_page.dart';
import 'package:mcproject/services/auth_service.dart';
import '/components/my-textfield.dart';
import '/components/my-button.dart';
import '/components/my-square-image.dart';
import 'package:google_sign_in/google_sign_in.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        );

    //provo a creare l'utente
    try {
      //controlliamo se le password corrispondono
      if(passwordController.text == passwordConfirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
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
      showErrorMessage();
    }
  }

  void showErrorMessage() {
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
                SingleChildScrollView(
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [

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

                                  Navigator.push(context,
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
