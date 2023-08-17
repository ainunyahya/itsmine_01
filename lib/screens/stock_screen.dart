import 'dart:async';
import 'dart:convert';

import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:itsmine_01/screens/crud_stockScreen/addData.dart';
import 'package:itsmine_01/screens/crud_stockScreen/updateData.dart';

import 'login_screen.dart';

class StockScreen extends StatefulWidget {
  StockScreen({Key? key}) : super(key :key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  late Timer _timer;

  List _listdata = [];
  bool _isloading = true;

  Future _getData() async {
    //String uri = "http://localhost/itsmine_app/crud/read.php";
    try {
      final response = await http.get(
          Uri.parse('http://localhost/itsmine_app/crud/read.php'));
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

  Future _deleteData(String id) async {
    //String uri = "http://localhost/itsmine_app/crud/read.php";
    try {
      final response = await http.post(
          Uri.parse('http://localhost/itsmine_app/crud/delete.php'),
      body: {
            "id" : id,
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _getData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
            title: const Text(
              "Stocks", style: TextStyle(color: Color(0xFF00B4FF)),),
            centerTitle: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => AddProduct())));
          },
          child: Icon(FluentSystemIcons.ic_fluent_add_regular),
        ),
        backgroundColor: Color(0xFFF4F4F4),
        body: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: 1.h, right: 10.w, left: 10.w),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: ListTile(
                        title: Text("Produk : " + _listdata[index]['name_product'],
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),),
                        subtitle: Text("Qty : " + _listdata[index]['qty_product'],
                          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                color: Color(0xFF1A4C6E),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                       return AlertDialog(
                                         content: Text("Yakin ingin menghapus data ini?"),
                                         actions: [
                                           ElevatedButton(onPressed: (){
                                             _deleteData(_listdata[index]['id'])
                                                 .then((value) {
                                               if (value) {
                                                 const snackBar = SnackBar(
                                                   content: Text('Data berhasil di Hapus!'),
                                                 );
                                                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                               } else {
                                                 const snackBar = SnackBar(
                                                   content: Text('Data gagal di Hapus!'),
                                                 );
                                                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                               }
                                             });
                                             Navigator.of(context).pop();
                                           }, child: Text("Hapus")),
                                           ElevatedButton(onPressed: (){
                                             Navigator.of(context).pop();
                                           }, child: Text("Batal")),
                                         ],
                                       );
                                      });
                                },
                                icon: Icon(FluentSystemIcons.ic_fluent_delete_regular,
                                  size: 20.w,)),
                            IconButton(
                                color: Color(0xFF1A4C6E),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateData(ListData: {
                                          "id" : _listdata[index]['id'],
                                          "name_product" : _listdata[index]['name_product'],
                                          "qty_product" : _listdata[index]['qty_product'],
                                        },)),
                                  );
                                },
                                icon: Icon(FluentSystemIcons.ic_fluent_edit_regular,
                                  size: 20.w,)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }
}


