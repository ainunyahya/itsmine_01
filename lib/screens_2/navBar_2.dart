import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itsmine_01/screens/stock_screen.dart';
import 'package:itsmine_01/screens_2/home_2.dart';


class ButtomNavBar2 extends StatefulWidget {
  const ButtomNavBar2({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar2> createState() => _ButtomNavBar2State();
}

class _ButtomNavBar2State extends State<ButtomNavBar2> {

  int _selectedIndex=0;
  static final List<Widget>_widgetOptions =<Widget>[
    const Home2Screen(),
    const Text("Screen 2"),
    const Text("Screen 3"),
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