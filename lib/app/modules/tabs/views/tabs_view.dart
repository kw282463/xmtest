import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      //重新渲染scaffold
      () => Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),//禁止滚动
          controller: controller.pageController,
          children: controller.pages,
          onPageChanged: (index) {
            //页面改变时注意菜单下标的变化
            controller.setCurrentIndex(index);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Colors.red, //选中颜色
          iconSize: 35, //底部菜单栏大小
          currentIndex: controller.currentIndex.value, //第几个菜单选中
          type: BottomNavigationBarType.fixed, //四个或者四个以上的菜单设置
          onTap: (index) {
            //点击改变下标索引值
            controller.setCurrentIndex(index);
            //点击左右滑动也可以选择页面
            controller.pageController.jumpToPage(index);
          },
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: '分类',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.room_service),
              label: '服务',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: '购物车',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '用户',
            ),
          ],
        ),
      ),
    );
  }
}
