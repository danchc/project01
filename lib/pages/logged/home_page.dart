import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/components/my-card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String formattedTime = DateFormat.yMMMEd().format(DateTime.now());
  var ora = int.parse(DateFormat.H().format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* colore background */
      backgroundColor: Colors.grey[300],

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
                  color: Colors.black87,
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
                  height: 250,
                  child: Center(
                    child: Container(
                      color: Colors.black87,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Text(
                              'U',
                              style: TextStyle(
                                fontSize: 90,
                              ),
                            ),
                          ),

                          /* frase saluto */
                          Container(
                            alignment: Alignment.center,
                            child: ora < 13?
                            const Text(
                              'Buongiorno!',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ):

                            const Text(
                              'Buonasera!',
                              style: TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [

                    MyCard(descrizione: 'Allenamenti', colore: Colors.deepOrange),
                    MyCard(descrizione: 'Nutrizione', colore: Colors.lightGreen),

                  ],
                ),


                const SizedBox(height: 200,),


                /* body */
                Column(
                  children: [
                    Center(
                      child: SvgPicture.asset('assets/images/void.svg',
                        height: 200,),
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

      /* nav bar */
      bottomNavigationBar: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: GNav(
            haptic: true,
            tabActiveBorder: Border.all(color: Colors.white, width: 1),
            color: Colors.white,
            activeColor: Colors.white,
            gap: 8,
            padding: const EdgeInsets.all(14),
            /* singoli bottoni */
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),

              GButton(
                icon: CupertinoIcons.timer,
                text: 'Allenamenti',
              ),

              GButton(
                icon: Icons.no_food_outlined,
                text: 'Nutrizione',
              ),

              GButton(
                icon: CupertinoIcons.gear_solid,
                text: 'Impostazioni',
              ),
            ],
          ),
        ),
      ),

    );
  }
}
