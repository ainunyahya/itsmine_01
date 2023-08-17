import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_layout.dart';

class UpdateData extends StatefulWidget {
  final Map ListData;
  const UpdateData({Key? key, required this.ListData}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {

  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name_product = TextEditingController();
  TextEditingController qty_product = TextEditingController();

  _update() async {
    final response = await http.post(
        Uri.parse('http://localhost/itsmine_app/crud/update.php'),
        body: {
          "id" : id.text,
          "name_product" : name_product.text,
          "qty_product" : qty_product.text
        });
    if (response.statusCode==200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    name_product.text = widget.ListData['name_product'];
    qty_product.text = widget.ListData['qty_product'];
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
        title: const Text("Edit product", style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700
        ),),
      ),
      backgroundColor: const Color(0xFFF4F4F4),
      body: Form(
        key: formKey,
        child: Container(
          width: Applayout.getScreenWidth(),
          height: Applayout.getScreenHeight(),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
              color: Colors.white
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                Text("Nama produk", style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w400),),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: TextFormField(
                    controller: name_product,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFFd9d9d9), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFFd9d9d9), width: 1),
                      ),
                      contentPadding: EdgeInsets.only(left: 15.w, right: 15.w, top: 17.h, bottom: 17.h),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Masukkan nama produk",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama produk tidak boleh kosong";
                      }
                    },
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("Jumlah produk", style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w400),),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: TextFormField(
                    controller: qty_product,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFFd9d9d9), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFFd9d9d9), width: 1),
                      ),
                      contentPadding: EdgeInsets.only(left: 15.w, right: 15.w, top: 17.h, bottom: 17.h),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Masukkan jumlah produk",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Jumlah produk tidak boleh kosong";
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.h,),
                Text('name_product'),
                SizedBox(height: 240.h,),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            foregroundColor: MaterialStateProperty.all(Colors.grey),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 14.h),),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(color: Colors.grey, width: 1.w),
                            ),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)
                            )),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                            ))),
                        child: const Text("Cancel")),
                  ),
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _update().then((value) {
                              if (value) {
                                final snackBar = const SnackBar(
                                  content: Text('Data berhasil di simpan!'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                final snackBar = const SnackBar(
                                  content: Text('Data gagal di simpan!'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            });
                            Navigator.pop(context);
                          };
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF00B4FF)),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(vertical: 14.h),),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)
                            )),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                            ))),
                        child: const Text("Update")),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
