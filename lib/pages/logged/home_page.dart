import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

                /* header */
                Container(
                  color: Colors.grey[600],
                  height: 300,
                ),

                const SizedBox(height: 80,),

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
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: GNav(
            haptic: true,
            tabActiveBorder: Border.all(color: Colors.white, width: 1),
            backgroundColor: Colors.black,
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
