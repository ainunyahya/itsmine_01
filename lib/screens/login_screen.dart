import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:itsmine_01/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:itsmine_01/screens_2/home_2.dart';
import 'package:itsmine_01/screens_2/navBar_2.dart';

import 'Navbar_screen.dart';
import 'gallon_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late String username, password, role;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //'http://localhost/itsmine_app/login.php'
  // 'username': _emailController.text,
  // 'password': _passwordController.text,

  Future<void> _handleLogin() async {
    //182.1.86.80 ip

    String usernameInput = _usernameController.text;
    String passwordInput = _passwordController.text;

    final String apiUrl = 'http://localhost/itsmine_app/login.php'; // Replace with your actual API URL

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'username': usernameInput, 'password': passwordInput},
    );

    final data = json.decode(response.body);

    if(data.length < 1){
      // if data user is empty or 0
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Invalid credentials. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
      });
    });
    }else{
      setState(() {
        username = data[0]["username"];
        password = data[0]["password"];
        role = data[0]["role"];
      });

      // move the page according to user status
      if(role == "admin"){
        // use navigator push replacement so that user can not go back to login page
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ButtomNavBar())
        );
      }else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Home2Screen())
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 88.h,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 78.w),
                      child: SizedBox(
                        width: 144.w,
                        height: 110.h,
                        child: Image.asset('assets/logo/logo-splash.png'),
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    Text("Username", style: TextStyle(fontSize: 14.sp),),
                    SizedBox(height: 10.h,),
                    TextField(
                      obscureText: false,
                      controller: _usernameController,
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
                        hintText: "Masukkan email",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Text("Password", style: TextStyle(fontSize: 14.sp),),
                    SizedBox(height: 10.h,),
                    TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: _passwordController,
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
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xFF00B4FF)),
                              foregroundColor: MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 14.h),),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)
                              )),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700
                              ))),
                          child: const Text("Login")),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
