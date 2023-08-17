import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Applayout{
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
  static getScreenHeight(){
    return Get.height;
  }
  static getScreenWidth(){
    return Get.width;
  }
  // start, (1). supaya size mengikuti size screen setiap handphone
  static getHeight(double pixels){
    double x = getScreenHeight()/pixels; // jika screen : 884/200 => 4.22 Inc.
    return getScreenHeight()/x;
  }
  static getWidth(double pixels){
    double x = getScreenWidth()/pixels; // jika screen : 884/200 => 4.22 Inc.
    return getScreenWidth()/x;
  }
}