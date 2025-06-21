import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/httpsclient.dart';
import '../../../widgets/screenAdapter.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  //左侧数据
  Widget _Left() {
    return Obx(
      () =>
          controller.isLoading.value
              ? Expanded(// 占满左侧模块的高度和宽度
                child: Center(child: CircularProgressIndicator()))
              : SizedBox(
                height: double.infinity,
                width: Screenadapter.width(280),
                //  color: Colors.yellow[100],
                child: //这里也可以Obx，但是会影响性能
                      ListView.builder(
                    itemCount: controller.leftcategoryList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        height: Screenadapter.height(180),
                        width: double.infinity,
                        child: Obx(
                          () => InkWell(
                            //点击事件
                            onTap: () {
                              controller.changeIndex(
                                index,
                                controller.leftcategoryList[index].sId,
                              ); //调用控制器的方法
                            },
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: Screenadapter.width(10),
                                    height: Screenadapter.height(46),
                                    color:
                                        controller.selectIndex.value == index
                                            ? Colors.red
                                            : Colors.white,
                                  ),
                                ),

                                Center(
                                  child: Text(
                                    "${controller.leftcategoryList[index].title}", // 模拟长文本

                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: Screenadapter.fontSize(36),
                                      fontWeight:
                                          controller.selectIndex.value == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                
              ),
    );
  }

  //右侧数据
  Widget _Right() {
    return //右侧
    Obx(
      () =>
          controller.isLoading.value
              ?  Expanded(// 占满左侧模块的高度和宽度
                child: Center(child: CircularProgressIndicator()))
              : Expanded(
                child: Obx(
                  () => GridView.builder(
                    itemCount: controller.rightcategoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //每行三个
                      mainAxisSpacing: Screenadapter.width(40), //主轴间距
                      crossAxisSpacing: Screenadapter.width(20),
                      childAspectRatio: 0.7, //宽高比
                    ),
                    itemBuilder: ((context, index) {
                      return InkWell(
                        //点击跳转
                        onTap: () {
                          Get.toNamed("/product-list",arguments: {
                            "cid":controller.rightcategoryList[index].sId,
                          });
                          print(controller.rightcategoryList[index].sId);
                        },
                        child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Image.network(HttpsClient.replaceUri("${controller.rightcategoryList[index].pic}")),
                          ),
                          SizedBox(height: Screenadapter.height(20)),
                          Text(
                            "${controller.rightcategoryList[index].title}",
                            style: TextStyle(
                              fontSize: Screenadapter.fontSize(32),
                            ),
                          ),
                        ],
                      ),
                      );
                    }),
                  ),
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: AnimatedContainer(
          width: Screenadapter.width(840),
          height: Screenadapter.height(96),
          decoration: BoxDecoration(
            color: Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          duration: Duration(milliseconds: 800),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
                child: Icon(Icons.search),
              ),
              Text(
                "搜索商品",
                style: TextStyle(fontSize: Screenadapter.fontSize(32)),
              ),
            ],
          ),
        ),
        onTap: () {
          Get.toNamed("/searchs");
        },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              //  Get.toNamed("page");
            },
            icon: Icon(Icons.message_outlined, color: Colors.black),
          ),
        ],
        elevation: 0,
      ),
      body: Row(children: [_Left(), _Right()]),
    );
  }
}
