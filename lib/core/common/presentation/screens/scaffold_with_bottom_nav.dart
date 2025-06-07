import 'package:echo/core/utils/extnesions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ScaffoldWithBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScaffoldWithBottomNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: context.width * .05, vertical: context.width * .05),
        color: Colors.black,
        child: GNav(
          gap: 8,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          haptic: true,
          padding: EdgeInsetsGeometry.all(16),
          onTabChange: (value) {
            navigationShell.goBranch(value);
          },
          tabs: [
            GButton(
              icon: FontAwesomeIcons.newspaper,
              text: "Top Headlines",
            ),
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: "Search",
            ),
            GButton(
              icon: FontAwesomeIcons.heart,
              text: "Saved",
            ),
          ],
        ),
      ),
    );
  }
}
