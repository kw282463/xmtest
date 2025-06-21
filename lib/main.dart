import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  //配置透明状态栏
  //flutter 修改状态栏的颜色
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(
    ScreenUtilInit(
      designSize: const Size(1080, 2400), //设计稿（期望软件页面的大小）的宽度和高度，单位px
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "xmshop", //应用后后台名
          initialRoute: AppPages.INITIAL,
          //配置动画
          //  defaultTransition: Transition.zoom,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false, //不显示debug
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white, // 显式设置AppBar背景色
              surfaceTintColor: Colors.transparent, // 关键：设置为透明，避免颜色叠加

              elevation: 4, //阴影
            ),
            scaffoldBackgroundColor: Colors.white, //设置所有的页面背景颜色
          ),
        );
      },
    ),
  );
}
