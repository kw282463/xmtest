import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screenadapter {
  static width(num v) {
    return v.w;
  }

  static height(num v) {
    return v.h;
  }

  static fontSize(num v) {
    return v.sp;
  }

  static getScreenWidth() {
    // return ScreenUtil().screenWidth;//设备宽度
    return 1.sw;
  }

  static getScreenHeight() {
    // return ScreenUtil().screenHeight;//设备高度
    return 1.sh;
  }

  //获取状态栏的高度
  static getStatusBarHeight(){
    return ScreenUtil().statusBarHeight;//状态栏高度 刘海屏会更高
  }
}
