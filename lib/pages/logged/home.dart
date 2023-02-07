import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/components/my-card.dart';
import '/pages/login_page.dart';
import 'package:mcproject/pages/logged/home_page.dart';
import 'package:mcproject/components/my-navbar.dart';

class Principale extends StatefulWidget {
  const Principale({Key? key}) : super(key: key);

  @override
  State<Principale> createState() => _PrincipaleState();
}

class _PrincipaleState extends State<Principale> {

  /* orario / data */
  String formattedTime = DateFormat.yMMMEd().format(DateTime.now());
  var ora = int.parse(DateFormat.H().format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* colore background */
      backgroundColor: Colors.grey[200],

      /* corpo principale */
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                /* giorno della settimana */
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: colore,
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
                  width: double.infinity,
                  height: 120,
                  child: Center(
                    child: Container(
                      color: colore,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          /* frase saluto */
                          Container(
                            alignment: Alignment.center,
                            child: ora < 13?
                            const Text(
                              'Buongiorno!',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ):

                            const Text(
                              'Buonasera!',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Container(
                            width: 80,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Text(
                              'U',
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20),
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    child: const Text(
                      'Il tuo sommario ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Barlow',
                      ),
                    ),
                  ),
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    MyCard(
                      descrizione: 'I tuoi allenamenti',
                      colore: Colors.blueAccent,
                      icona: Icons.sports_gymnastics,
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage())),
                      },
                    ),

                    MyCard(
                        descrizione: 'La tua dieta',
                        colore: Colors.white,
                        icona: Icons.emoji_food_beverage,
                        onTap: () => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage())),
                        }
                    ),

                  ],
                ),


                const SizedBox(height: 15,),


                /* body */
                Column(
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/images/void.svg',
                        height: 170,),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Mi sembra ancora vuoto!',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Barlow',
                        ),
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

    );
  }
}
