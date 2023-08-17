import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmine_01/screens/stock_screen.dart';

import 'gallon_screen.dart';
import 'home_screen.dart';

class ButtomNavBar extends StatefulWidget {
  const ButtomNavBar({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {

  int _selectedIndex=0;
  static final List<Widget>_widgetOptions =<Widget>[
    const HomeScreen(),
    const GallonScreen(),
    StockScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 10,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed, //shifting(animation bottom), fixed(fixed bottom)
          unselectedItemColor: const Color(0xFF110B04),
          items: const [
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
                activeIcon : Icon(FluentSystemIcons.ic_fluent_home_filled),
                label: "Home"),
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_history_regular),
                activeIcon : Icon(FluentSystemIcons.ic_fluent_history_filled),
                label: "History"),
            BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_organization_chart_regular),
                activeIcon : Icon(FluentSystemIcons.ic_fluent_organization_chart_filled),
                label: "Chart"),
          ]),
    );
  }
}