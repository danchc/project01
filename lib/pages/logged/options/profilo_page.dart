import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:mcproject/components/my-readonly-textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountDetails extends StatefulWidget {
  AccountDetails({Key? key}) : super(key: key);

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  /* controllers */
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordConfirmController = TextEditingController();

  /* informazioni utente */
  final user = FirebaseAuth.instance.currentUser!;

  /* key form */
  final _formKey = GlobalKey<FormState>();

  String photoURL = '';

  /* altre variabili */
  final bool readOnly = true;
  bool hide = true;
  IconData icona = LineIcons.eye;

  @override
  void initState() {
    hide = true;
    icona = LineIcons.eye;
    photoURL = 'https://via.placeholder.com/510x510?text=No+photo';
    super.initState();
  }

  /* metodo hide password */
  void hidePassword() {
    setState(() {
      if(hide) {
        hide = false;
        icona = LineIcons.eyeSlash;
      } else {
        hide = true;
        icona = LineIcons.eye;
      }
    });
  }

  void uploadImage() async {
    final image = await ImagePicker()
        .pickImage(
          source: ImageSource.gallery,
          maxWidth: 512,
          maxHeight: 512,
          imageQuality: 75
        );

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
    });
  }

  /* metodo per aggiornare password */
  void aggiornaPassword() async{

    /* verifichiamo che non ci siano errori */
    if (_formKey.currentState!.validate()) {
      /* se le password corrispondono */
      if(passwordController.text == passwordConfirmController) {
        /* aggiorniamo i dati */
        await user.updatePassword(passwordController.text);
        Navigator.pop(context);

        Dialogs.bottomMaterialDialog(
            context: context,
            color: Colors.white,
            msg: 'La password è stata aggiornata',
            title: 'Grande!',
            lottieBuilder: Lottie.asset(
              'assets/animations/done.json',
              fit: BoxFit.contain,
            ),
            actions: [
              IconsButton(
                onPressed: () {Navigator.pop(context);},
                text: 'Ricevuto',
                iconData: Icons.done,
                color: Colors.green,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]
        );

      } else {
        Navigator.pop(context);
        Dialogs.bottomMaterialDialog(
            context: context,
            color: Colors.white,
            msg: 'Le password non corrispondono',
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
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Dettagli account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Barlow',
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              color: Colors.blueAccent,
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 35.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 90,
                    child: CircleAvatar(
                      radius: 85,
                      backgroundImage: NetworkImage(photoURL),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () => {
                            log('cambia foto premuto'),
                            uploadImage(),
                          },
                          child: Container(
                            height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.black,
                              ),
                              child: const Icon(Icons.photo_camera,size: 40,)
                          ),
                        ),
                      ),
                    )
                  )
                ),
              )
            ),

            Container(
                color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      /* username */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Container(
                               margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Barlow',
                                  color: Color.fromARGB(255, 11, 49, 93),
                                  fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),
                      ROTextfield(
                          testo: user.displayName ?? 'Non presente',
                          hide: false,
                          readOnly: readOnly,
                      ),

                      /* email */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'E-mail',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Barlow',
                                    color: Color.fromARGB(255, 11, 49, 93),
                                    fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),
                      ROTextfield(
                        testo: user.email ?? 'Non presente',
                        hide: false,
                        readOnly: readOnly,
                      ),

                      /* password */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              child: const Text(
                                  'Password',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Barlow',
                                    color: Color.fromARGB(255, 11, 49, 93),
                                    fontSize: 20
                                ),
                              )
                          ),
                        ],
                      ),

                      ROTextfield(
                        testo: '****',
                        hide: true,
                        readOnly: readOnly,
                          icona: Icons.edit,
                        onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(

                                title: Text('Aggiorna password'),

                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [


                                      //input password
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if(value == null || value.isEmpty) {
                                              return '*Obbligatorio';
                                            }
                                            return null;
                                          },
                                          controller: passwordController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Password',
                                              suffixIcon: IconButton(
                                                icon: Icon(icona),
                                                onPressed: hidePassword,
                                              ),
                                          ),
                                          obscureText: hide,
                                        ),
                                      ),

                                      //input password conferma
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: TextFormField(
                                          validator: (value) {
                                            if(value == null || value.isEmpty) {
                                              return '*Obbligatorio';
                                            }
                                            return null;
                                          },
                                          controller: passwordConfirmController,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Conferma Password',
                                              suffixIcon: IconButton(
                                                  icon: Icon(icona),
                                                  onPressed: hidePassword,
                                              ),
                                          ),
                                          obscureText: hide,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                actions: [
                                  Center(
                                    child: Material(
                                      color: Colors.black,
                                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                      elevation: 18.0,
                                      clipBehavior: Clip.antiAlias,
                                      child: MaterialButton(
                                          onPressed: aggiornaPassword,
                                          child: const Text(
                                            'Salva',
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ),

                        },
                      ),


                    ],
                  ),
                ),
              ),
            ),

            SizedBox(child: Container(height: 100,),)
         ],
        ),
      ),

    );
  }
}
