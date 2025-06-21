import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/widgets/httpsClient.dart';

import '../../../widgets/screenAdapter.dart';
import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});

  //标题头
  Widget _subHead() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Obx(
        () => Container(
          height: Screenadapter.height(120),
          width: Screenadapter.width(1080),

          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: Screenadapter.height(1),
                color: Colors.white,
              ),
            ),
          ),
          child: Row(
            children:
                controller.subHeaderList.map((value) {
                  print(value);
                  return Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              Screenadapter.height(16),
                              0,
                              Screenadapter.height(16),
                            ),
                            child: Text(
                              "${value["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    controller.selectHeaderId.value ==
                                            value["id"]
                                        ? Colors.red
                                        : Colors.black,
                                fontSize: Screenadapter.fontSize(32),
                              ),
                            ),
                          ),
                          onTap: () {
                            //打开侧边栏
                            controller.subHeadChange(value["id"]);
                          },
                        ),
                        _showIcon(value["id"]),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  //自定义箭头组件
  Widget _showIcon(id) {
    //controller.subheadSort.value==1每次点击改变widget状态
    if (id == 2 ||
        id == 3 ||
        controller.subheadSort.value == 1 ||
        controller.subheadSort.value == -1) {
      if (controller.subHeaderList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down, color: Colors.black54);
      }
      return Icon(Icons.arrow_drop_up, color: Colors.black54);
    } else {
      return const Text("");
    }
  }

  //内容
  Widget _productList() {
    return ListView.builder(
      controller: controller.scrollController,
      padding: EdgeInsets.fromLTRB(
        Screenadapter.width(20),
        Screenadapter.width(130),
        Screenadapter.width(20),
        0,
      ),
      itemCount: controller.plist.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: Screenadapter.height(20)),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  //左侧
                  Container(
                    padding: EdgeInsets.all(Screenadapter.width(20)),
                    height: Screenadapter.height(460),
                    width: Screenadapter.width(400),
                    child: Image.network(
                      HttpsClient.replaceUri("${controller.plist[index].sPic}"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  //右侧
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: Screenadapter.height(20),
                          ),
                          child: Text(
                            "${controller.plist[index].title}",
                            style: TextStyle(
                              fontSize: Screenadapter.fontSize(42),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: Screenadapter.height(20),
                          ),
                          child: Text(
                            "${controller.plist[index].subTitle}",
                            style: TextStyle(
                              fontSize: Screenadapter.fontSize(34),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            bottom: Screenadapter.height(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "CPU",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(34),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "hello",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(28),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "CPU",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(34),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "hello",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(28),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "CPU",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(34),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "hello",
                                      style: TextStyle(
                                        fontSize: Screenadapter.fontSize(28),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${controller.plist[index].price}",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(38),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //在最后一个加上圈圈
            (index == controller.plist.length - 1)
                ? _progressCircle()
                : const SizedBox(height: 0), //不要加Text（""）,本身是有高度的
          ],
        );
      },
    );
  }

  //自定义组件
  Widget _progressCircle() {
    if (controller.hasData.value) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Center(child: Text("没有数据了"));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
      key: controller.scaffoldGlobalKey,
      endDrawer: Drawer(child: DrawerHeader(child: Text("筛选"))),
      appBar: AppBar(
        //  automaticallyImplyLeading: false,//隐藏Scaffold中endDrawer对应的图
        actions: [
          Visibility(
            //将图标隐藏
            visible: false,
            child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // 打开抽屉
              },
              icon: Icon(Icons.menu),
            ),
          ),
        ],
        title: AnimatedContainer(
          width: Screenadapter.width(900),
          height: Screenadapter.height(96),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          duration: Duration(milliseconds: 800),
          child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
                  child: Icon(Icons.search),
                ),
                Text(
                  controller.keywords != null ? "${controller.keywords}" : "",
                  style: TextStyle(fontSize: Screenadapter.fontSize(32)),
                ),
              ],
            ),
            onTap: () {
              //点击跳转到搜索
              Get.offAndToNamed("/searchs");
            },
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,

        elevation: 0,
      ),
      body: Obx(
        () =>
            controller.plist.isNotEmpty
                ? Stack(children: [_productList(), _subHead()])
                : _progressCircle(),
      ),
    );
  }
}
