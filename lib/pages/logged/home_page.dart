import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mcproject/constants/constants.dart';
import 'package:mcproject/components/my-card.dart';
import 'package:mcproject/pages/logged/scheda_allenamenti.dart';
import 'package:mcproject/pages/logged/home.dart';
import 'package:mcproject/pages/logged/nutrizione/nutrizione.dart';
import 'package:mcproject/pages/logged/options/profilo.dart';
import '/pages/login_page.dart';
import 'package:mcproject/components/my-navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /* impostata sulla homepage */
  int currentIndex = 0;

  /* lista delle pagine */
  final List<Widget> _tabItems = [
    Principale(),
    Allenamenti(),
    Nutrizione(),
    Profilo()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* corpo principale */
      body: _tabItems[currentIndex],

      /* nav bar */
      bottomNavigationBar: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: GNav(
            onTabChange: (index) => {
              setState(() {currentIndex = index;})
            },
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
