import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../widgets/app_layout.dart';



class detailOrder extends StatefulWidget {
  final Map ListData;
   detailOrder({Key? key, required this.ListData}) : super(key: key);

  @override
  State<detailOrder> createState() => _detailOrderState();
}

class _detailOrderState extends State<detailOrder> {

  TextEditingController id = TextEditingController();

  List _listdata = [];
  bool _isloading = true;

  Future _cancelData() async {
    try {
      final response = await http.post(
          Uri.parse('http://localhost/itsmine_app/detail_order/detail1.php'),
      body: {
        "orders.id" : id.text,
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data ??['id'] ;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _cancelData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60.h,
        backgroundColor: Color(0xFFF4F4F4),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            size: 25.w,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text("Detail Orders", style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700
        ),),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      body: Container(
        width: Applayout.getScreenWidth(),
        height: Applayout.getScreenHeight(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
            color: Colors.blue
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _listdata.length,
            itemBuilder: (context, index) {
              final String? nameCustomer = _listdata[index]['name_customer'];
              final String? dateOrder = _listdata[index]['date_order'];
              final dateTime = DateTime.parse(_listdata[index]['date_order']);
              final date = DateFormat.yMd().format(dateTime);
              final time = DateFormat.Hm().format(dateTime);
              final dateTime1 = DateTime.parse(_listdata[index]['date_delivery']);
              final date1 = DateFormat.yMd().format(dateTime1);
              final time1 = DateFormat.Hm().format(dateTime1);
              return Column(
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
                                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("#000" + _listdata[index]['id'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black
                                        ),),
                                      SizedBox(height: 7.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFd9d9d9), width: 0.5.w),
                                          // Garis dengan warna dan lebar yang sesuai// Radius sudut dari border
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.person,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(_listdata[index]['name_customer'],
                                          style: TextStyle(
                                            fontSize: 13.sp
                                          ),),
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
                                          SizedBox(width: 8.w,),
                                          Text('$time',
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
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
                                          Text('$date',
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height: 1.h,),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.location,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(_listdata[index]['address_order'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height: 1.h,),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.phone,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(_listdata[index]['no_telp'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height: 7.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFd9d9d9), width: 0.5.w),
                                          // Garis dengan warna dan lebar yang sesuai// Radius sudut dari border
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Text("Catatan :",
                                        style: TextStyle(
                                            fontSize: 13.sp
                                        ),),
                                      Text(_listdata[index]['note'],
                                        style: TextStyle(
                                            fontSize: 13.sp
                                        ),),
                                      SizedBox(height: 10.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFd9d9d9), width: 0.5.w),
                                          // Garis dengan warna dan lebar yang sesuai// Radius sudut dari border
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        children: [
                                          Text(_listdata[index]['qty'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                          Text("  ",
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                          Text(_listdata[index]['name_product'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xFFd9d9d9), width: 0.5.w),
                                          // Garis dengan warna dan lebar yang sesuai// Radius sudut dari border
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Text("Riwayat pengiriman",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700
                                        ),),
                                      SizedBox(height: 3.h,),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.person,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(_listdata[index]['name'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            FluentSystemIcons.ic_fluent_battery_warning_regular,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(_listdata[index]['name_warehouse'],
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.clock,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text('$time1',
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.calendar,
                                            size: 18.w,
                                            color: Color(0xFF8A8A8A),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text('$date1',
                                            style: TextStyle(
                                                fontSize: 13.sp
                                            ),),
                                        ],
                                      ),

                                      SizedBox(height: 40.h,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              );
            },
          ),
        ),
      )
    );
  }
}
