import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/views/cart_view.dart';
import '../../category/views/category_view.dart';
import '../../give/views/give_view.dart';
import '../../home/views/home_view.dart';
import '../../user/views/user_view.dart';

class TabsController extends GetxController {
  //解决完成注册直接跳转到用户中心，下标也在用户页面

  //TODO: Implement TabsController

  RxInt currentIndex = 0.obs;

  //初始化pageView页面
  PageController pageController =
      Get.arguments != null
          ? PageController(initialPage: Get.arguments["initialPage"])
          : PageController(initialPage: 0);
  //引入页面
  final List<Widget> pages = [
    HomeView(),
    CategoryView(),
    GiveView(),
    CartView(),
    UserView(),
  ];
  @override
  void onInit() {
    if (Get.arguments != null) {
      currentIndex.value = Get.arguments["initialPage"];
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //控制index'的方法
  void setCurrentIndex(index) {
    currentIndex.value = index;
    update(); //更新
  }
}
