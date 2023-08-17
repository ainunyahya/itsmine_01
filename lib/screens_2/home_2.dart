import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../screens/addorders_screen.dart';
import '../screens/login_screen.dart';

class Home2Screen extends StatefulWidget {
  const Home2Screen({Key? key}) : super(key: key);

  @override
  State<Home2Screen> createState() => _Home2ScreenState();
}

class _Home2ScreenState extends State<Home2Screen> {

  List _listdata = [];
  bool _isloading = true;

  Future _getData() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/itsmine_app/orders/order_read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          toolbarHeight: 60.h,
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
          title: const Text("Orders", style: TextStyle(
              color: Color(0xFF00B4FF)
          ),),
        ),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      //Categories(),
      body: DefaultTabController(
          length: 6,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                child: TabBar(
                    automaticIndicatorColorAdjustment: true,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: const Color(0xFF00B4FF),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF))
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Hari ini",),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF),)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Semua"),
                            ),
                          ),
                        ),
                      ),Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF),)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Belum diproses"),
                            ),
                          ),
                        ),
                      ),Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF),)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Sedang diproses"),
                            ),
                          ),
                        ),
                      ),Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF),)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Selesai diproses"),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: const Color(0xFF00B4FF),
                                width: 1.w,)
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.w, right: 10.w,),
                              child: const Text("Dibatalkan"),
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Expanded(
                  child: TabBarView(
                      children: [
                        Center(child: Text("1"),),
                        _isloading ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Color of the indicator
                            strokeWidth: 5.0, // Width of the indicator's stroke
                          ),
                        )
                            :ListView.builder(
                          itemCount: _listdata.length,
                          itemBuilder: (context, index) {
                            final dateTime = DateTime.parse(_listdata[index]['date_order']);
                            final date = DateFormat.yMd().format(dateTime);
                            final time = DateFormat.Hm().format(dateTime);
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => detailOrder()),
                                // );
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 5.h, right: 10.w, left: 10.w),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.only(top: 10.h, bottom: 6.h),
                                            title: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left: 10.w),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("#000" + _listdata[index]['id'],
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.w700,
                                                            color: Color(0xFF8A8A8A)
                                                        ),),
                                                      SizedBox(height: 7.h,),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons.person,
                                                            size: 18.w,
                                                            color: Color(0xFF8A8A8A),
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text(_listdata[index]['name_customer']),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons.clock,
                                                            size: 18.w,
                                                            color: Color(0xFF8A8A8A),
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text('$time'),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons.calendar,
                                                            size: 18.w,
                                                            color: Color(0xFF8A8A8A),
                                                          ),
                                                          SizedBox(width: 8.w),
                                                          Text('$date'),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10.h,),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFFd9d9d9), width: 0.5.w),
                                                    // Garis dengan warna dan lebar yang sesuai// Radius sudut dari border
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 12.w,top: 6.h),
                                                  child: Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(_listdata[index]['status'],
                                                      style: const TextStyle(
                                                        color: Color(0xFF5a5a5a,
                                                        ),),
                                                    ),
                                                  ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Center(child: Text("3"),),
                        Center(child: Text("4"),),
                        Center(child: Text("5"),),
                        Center(child: Text("6"),),
                      ]
                  )
              )
            ],
          )),
    );
  }
}
