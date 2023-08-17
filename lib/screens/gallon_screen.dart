import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

class GallonScreen extends StatefulWidget {
  const GallonScreen({Key? key}) : super(key: key);

  @override
  State<GallonScreen> createState() => _GallonScreenState();
}

class _GallonScreenState extends State<GallonScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Change the length to the number of tabs you want
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                    child: Icon(
                      FluentSystemIcons.ic_fluent_person_regular,
                      size: 100.w,
                      color: Colors.white,
                    )
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Keluar'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()),
                  );
                },
              ),
              // Add more ListTiles for additional items
            ],
          ),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
              margin: const EdgeInsets.only(left: 10),
              width: 50.w,
              height: 50.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    FluentSystemIcons.ic_fluent_person_regular,
                    size: 25.w,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            title: const Text("Galon Kosong", style: TextStyle(color: Color(0xFF00B4FF)),),
            centerTitle: true,
            toolbarHeight: 60.h,
          ),
        ),
        backgroundColor: Color(0xFFF4F4F4),
        body:SafeArea(
            child: Center(
              child: Text("Galon"),
            ))
    );
  }
}
