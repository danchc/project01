import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:mcproject/pages/login_page.dart';
import 'package:mcproject/pages/logged/home_page.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({Key? key}) : super(key: key);

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
    final List<Widget> _tabItems = [HomePage(), LoginPage()];
    int currentIndex = 0;


    @override
    Widget build(BuildContext context) {
      return Container(
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
      );
    }
  }


