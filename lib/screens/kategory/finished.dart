import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../detailOrder/detailOrder_screen.dart';

class ListTab extends StatefulWidget {
  final List<String> data;


  ListTab({required this.data});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {

  List _listdata1 = [];
  bool _isloading = true;

  Future _selesaiData() async {
    try {
      final response = await http.get(
          Uri.parse('http://localhost/itsmine_app/orders/finished.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata1 = data;
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
    _selesaiData();
  }

  @override
  Widget build(BuildContext context) {
    return  _isloading
            ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Color of the indicator
                strokeWidth: 5.0, // Width of the indicator's stroke
              ),
        ) :
      ListView.builder(
      itemCount: _listdata1.length,
      itemBuilder: (context, index) {
        final dateTime = DateTime.parse(_listdata1[index]['date_order']);
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
                                  Text("#000" + _listdata1[index]['id'],
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
                                      Text(_listdata1[index]['name_customer']),
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
                                child: Text(_listdata1[index]['status'],
                                  style: const TextStyle(color: Color(0xFF5a5a5a)),),
                              ),
                            ),
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
    );
  }
}