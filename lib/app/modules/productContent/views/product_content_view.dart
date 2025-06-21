import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/product_content_controller.dart';
import "../../../widgets/screenAdapter.dart";
import './first_page_view.dart';
import './second_page_view.dart';
import "./third_page_view.dart";
import './cart_item_num_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({super.key});

  //bottomSheet更新流数据需要使用 GetBuilder 来渲染数据
  //action 1点击的是筛选属性。2点击的是加入购物车，3表示点击的是立即购买
  void showBottomAttr(int action) {
    Get.bottomSheet(
      GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(Screenadapter.width(20)),
            width: double.infinity,
            height: Screenadapter.height(1200),
            child: Stack(
              children: [
                ListView(
                  children: [
                    ...controller.pcontent.value.attr!.map((v) {
                      return Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: Screenadapter.height(20),
                              left: Screenadapter.width(20),
                            ),
                            width: Screenadapter.width(1040),
                            child: Text(
                              "${v.cate}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: Screenadapter.height(20),
                              left: Screenadapter.width(20),
                            ),
                            width: Screenadapter.width(1040),
                            child: Wrap(
                              children:
                                  v.attrList!.map((value) {
                                    return InkWell(
                                      onTap: () {
                                        controller.changeAttr(
                                          v.cate,
                                          value["title"],
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(
                                          Screenadapter.width(20),
                                        ),
                                        child: Chip(
                                          padding: EdgeInsets.only(
                                            left: Screenadapter.width(20),
                                            right: Screenadapter.width(20),
                                          ),
                                          backgroundColor:
                                              value["checked"] == true
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                    31,
                                                    223,
                                                    213,
                                                    213,
                                                  ),
                                          label: Text(value["title"]),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ],
                      );
                    }),
                    Padding(
                      padding: EdgeInsets.all(Screenadapter.height(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(
                            "数量",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          CartItemNumView(),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 2,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,

                  child:
                      action == 1
                          ? Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: Screenadapter.height(120),
                                  margin: EdgeInsets.only(
                                    right: Screenadapter.width(20),
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        const Color.fromRGBO(255, 165, 0, 0.9),
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        // CircleBorder()
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.addCart();
                                    },
                                    child: Text("加入购物车"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: Screenadapter.height(120),
                                  margin: EdgeInsets.only(
                                    right: Screenadapter.width(20),
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        const Color.fromRGBO(253, 1, 0, 0.9),
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        // CircleBorder()
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.buy();
                                    },
                                    child: Text("立即购买"),
                                  ),
                                ),
                              ),
                            ],
                          )
                          : Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: Screenadapter.height(120),
                                  margin: EdgeInsets.only(
                                    right: Screenadapter.width(20),
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                        const Color.fromRGBO(253, 1, 0, 0.9),
                                      ),
                                      foregroundColor: WidgetStatePropertyAll(
                                        Colors.white,
                                      ),
                                      shape: WidgetStatePropertyAll(
                                        // CircleBorder()
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (action == 2) {
                                        print("加入购物车");
                                        controller.addCart();
                                      } else {
                                        print('立即购买');
                                        controller.buy();
                                      }
                                    },
                                    child: Text("确定"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Obx(
      () => AppBar(
        leading: Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: Screenadapter.width(88),
            height: Screenadapter.width(88),
            child: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                //注意:去掉button默认的padding
                padding: WidgetStatePropertyAll(const EdgeInsets.all(0)),
                alignment: Alignment.center,
                backgroundColor: WidgetStatePropertyAll(Colors.black12),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(const CircleBorder()),
              ),
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
        ),
        title: SizedBox(
          width: Screenadapter.width(400),
          height: Screenadapter.height(96),
          child:
              controller.showTabs.value
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        controller.tabsList.map((v) {
                          return InkWell(
                            //不要颜色，只要点击点击动画
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              controller.changeSelectedTabsIndex(v["id"]);
                              //跳转到指定的容器
                              if (v["id"] == 1) {
                                Scrollable.ensureVisible(
                                  controller.gk1.currentContext as BuildContext,
                                  duration: const Duration(milliseconds: 300),
                                );
                              } else if (v["id"] == 2) {
                                Scrollable.ensureVisible(
                                  controller.gk2.currentContext as BuildContext,
                                  duration: const Duration(milliseconds: 300),
                                );
                                //修正（不修正直接写，会卡在详情，点击商品不会跳转到最上面）
                                Timer(Duration(milliseconds: 500), () {
                                  //跳转到指定内容，不要遮挡
                                  controller.scrollController.jumpTo(
                                    controller
                                            .scrollController
                                            .position
                                            .pixels -
                                        Screenadapter.height(160),
                                  );
                                });
                              } else {
                                Scrollable.ensureVisible(
                                  controller.gk3.currentContext as BuildContext,
                                  duration: const Duration(milliseconds: 300),
                                );
                                //修正（不修正直接写，会卡在详情，点击商品不会跳转到最上面）
                                Timer(Duration(milliseconds: 500), () {
                                  //跳转到指定内容，不要遮挡
                                  controller.scrollController.jumpTo(
                                    controller
                                            .scrollController
                                            .position
                                            .pixels -
                                        Screenadapter.height(160),
                                  );
                                });
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${v["title"]}",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(36),
                                  ),
                                ),
                                v["id"] == controller.selectedTabsIndex.value
                                    ? Container(
                                      margin: EdgeInsets.only(
                                        top: Screenadapter.height(10),
                                      ),
                                      width: Screenadapter.width(100),
                                      height: Screenadapter.height(2),
                                      color: Colors.red,
                                    )
                                    : Container(
                                      margin: EdgeInsets.only(
                                        top: Screenadapter.height(10),
                                      ),
                                      width: Screenadapter.width(100),
                                      height: Screenadapter.height(2),
                                    ),
                              ],
                            ),
                          );
                        }).toList(),
                  )
                  : const Text(""),
        ),
        centerTitle: true,
        backgroundColor: Colors.white.withOpacity(
          controller.opcity.value,
        ), //实现透明导航
        elevation: 0, //实现透明导航
        actions: [
          Container(
            margin: EdgeInsets.only(right: Screenadapter.width(20)),
            width: Screenadapter.width(88),
            height: Screenadapter.width(88),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                //注意:去掉button默认的padding
                padding: WidgetStatePropertyAll(const EdgeInsets.all(0)),
                alignment: Alignment.center,
                backgroundColor: WidgetStatePropertyAll(Colors.black12),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(const CircleBorder()),
              ),
              child: const Icon(Icons.file_upload_outlined),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: Screenadapter.width(20)),
            width: Screenadapter.width(88),
            height: Screenadapter.width(88),
            child: ElevatedButton(
              onPressed: () {
                showMenu(
                  color: Colors.black87.withOpacity(0.7),
                  context: context,
                  position: RelativeRect.fromLTRB(
                    Screenadapter.width(800),
                    Screenadapter.height(220),
                    Screenadapter.width(20),
                    0,
                  ),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.home, color: Colors.white),
                          Text("首页", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.message, color: Colors.white),
                          Text("消息", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: const [
                          Icon(Icons.star, color: Colors.white),
                          Text("收藏", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                );
              },
              style: ButtonStyle(
                //注意
                padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                alignment: Alignment.center,
                backgroundColor: WidgetStatePropertyAll(Colors.black12),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(const CircleBorder()),
              ),
              child: const Icon(Icons.more_horiz_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _subHeader() {
    return Obx(
      () => Container(
        color: Colors.white,
        child: Row(
          children:
              controller.subTabList.map((value) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.changeSelectedSubTabsIndex(value["id"]);
                    },
                    child: Container(
                      height: Screenadapter.height(120),
                      alignment: Alignment.center,
                      child: Text(
                        "${value["title"]}",
                        style: TextStyle(
                          color:
                              controller.selectedSubTabsIndex == value["id"]
                                  ? Colors.red
                                  : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FirstPageView(showBottomAttr),
          SecondPageView(_subHeader),
          ThirdPageView(),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: Screenadapter.height(240),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              width: Screenadapter.width(2),
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: Screenadapter.width(200),
              height: Screenadapter.height(160),
              child: InkWell(
                onTap: () {
                  Get.toNamed("/cart");
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart),
                    Text(
                      "购物车",
                      style: TextStyle(fontSize: Screenadapter.fontSize(32)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: Screenadapter.width(30)),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: Screenadapter.height(120),

                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      const Color.fromRGBO(255, 165, 0, 0.9),
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      // CircleBorder()
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showBottomAttr(2);
                  },
                  child: Text("加入购物车"),
                ),
              ),
            ),
            SizedBox(width: Screenadapter.width(30)),
            Expanded(
              flex: 1,
              child: Container(
                height: Screenadapter.height(120),
                margin: EdgeInsets.only(right: Screenadapter.width(20)),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      const Color.fromRGBO(253, 1, 0, 0.9),
                    ),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    shape: WidgetStatePropertyAll(
                      // CircleBorder()
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showBottomAttr(3);
                  },
                  child: Text("立即购买"),
                ),
              ),
            ),
            SizedBox(width: Screenadapter.width(30)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //实现透明导航
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Screenadapter.height(160)),
        child: _appBar(context),
      ),
      body: Stack(
        children: [
          _body(),
          _bottom(),
          Obx(
            () =>
                controller.showSubHeader.value
                    ? Positioned(
                      left: 0,
                      top:
                          Screenadapter.getStatusBarHeight() +
                          Screenadapter.height(160),
                      right: 0,
                      child: _subHeader(),
                    )
                    : const Text(""),
          ),
        ],
      ),
    );
  }
}
