import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/components/my-card.dart';
import 'package:mcproject/data/allenamenti_data.dart';
import 'package:provider/provider.dart';
import '../../components/my-scheda-notizia.dart';
import '../../data/nutrizione_data.dart';
import '../../model/article_model.dart';
import '../../services/api_service.dart';

class Principale extends StatefulWidget {
  const Principale({Key? key}) : super(key: key);

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {

  /* orario / data */
  String formattedTime = DateFormat.yMMMEd().format(DateTime.now());
  var ora = int.parse(DateFormat.H().format(DateTime.now()));

  /* informazioni utente */
  final user = FirebaseAuth.instance.currentUser!;

  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* colore background */
      backgroundColor: Colors.grey[200],

      /* corpo principale */
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              /* giorno della settimana */
              Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.only(top: 50),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  formattedTime,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
              ),

              /* header */
              Container(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: Offset(4, 8), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /* frase saluto */
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: ora < 13 && ora > 5?
                              Row(
                                children: [
                                  Icon(
                                      Icons.waving_hand_outlined,
                                  color: Colors.white,
                                  size: 35,),
                                  const Text(
                                    ' Buongiorno,',
                                    style: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ):

                              Row(
                                children: [
                                  Icon(
                                    Icons.waving_hand_outlined,
                                    color: Colors.white,
                                    size: 35,),
                                  const Text(
                                    'Buonasera,',
                                    style: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                '${user.displayName}',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Text(
                            user.displayName![0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),



              /* il tuo sommario */
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  padding: EdgeInsets.only(top: 20.0),
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    'Il tuo sommario ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  height: 20,
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),

              /* cards */
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    MyCard(
                      descrizione: 'I tuoi allenamenti',
                      colore: Colors.white,
                      icona: Icons.sports_gymnastics,
                      numero: Provider.of<AllenamentiData>(context, listen: false).getListaSchede().length,
                    ),

                    MyCard(
                      descrizione: 'La tua alimentazione',
                      colore: Colors.white,
                      icona: Icons.emoji_food_beverage,
                      numero: Provider.of<NutrizioneData>(context, listen: false).getSchedeNutrizioni().length,
                    ),

                  ],
                ),
              ),

              /* le news */
              Padding (
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: const Text(
                    'Esplora ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Barlow',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  height: 20,
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),

              FutureBuilder(
              future: client.getArticle(),
              builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {

              if (snapshot.hasData) {
                List<Article>? articles = snapshot.data;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) =>
                      customListTile(articles![index], context),
                );
              } else if(snapshot.data == null){
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
              } else {
                return const Center(
                  child: Text('Ops! Si è verificato qualche errore.'),
                );
              }
              }),
            ],
          ),
        ),
      ),

    );
  }
}


