import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/screenAdapter.dart';
import '../controllers/searchs_controller.dart';
import '../../../widgets/searchServices.dart';

class SearchsView extends GetView<SearchsController> {
  const SearchsView({super.key});

  //搜索历史
  Widget _searchHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Obx(
          () =>
              controller.historyList.isNotEmpty
                  ? Padding(
                    padding: EdgeInsets.only(bottom: Screenadapter.height(0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "搜索历史",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(38),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.all(
                                  Screenadapter.width(20),
                                ),

                                height: Screenadapter.height(360),
                                width: Screenadapter.width(1080),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("你确定删除吗")],
                                    ),
                                    SizedBox(height: Screenadapter.height(20)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("取消"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.clearHistoryData();
                                            Get.back();
                                          },
                                          child: Text("确定"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                            //清除历史
                          },
                          icon:Icon(Icons.delete_forever,),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox(height: 0),
        ),

        Obx(
          () => Wrap(
            children:
                controller.historyList
                    .map(
                      (value) =>
                      //内容点击事件
                      GestureDetector(
                        child:  Container(
                        padding: EdgeInsets.fromLTRB(
                          Screenadapter.height(26),
                          0,
                          Screenadapter.height(26),
                          Screenadapter.height(26),
                        ),
                        margin: EdgeInsets.all(Screenadapter.height(5)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(value),
                      ),
                      //双击删除历史记录
                        onDoubleTap: () => 
                        controller.deleteHistoryData(value),
                      )
                     
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  //猜你想搜
  Widget _guessSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Screenadapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "猜你想搜",
                style: TextStyle(fontSize: Screenadapter.fontSize(38)),
              ),
              Icon(Icons.refresh_rounded),
            ],
          ),
        ),

        Wrap(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                Screenadapter.height(26),
                Screenadapter.height(16),
                Screenadapter.height(26),
                Screenadapter.height(16),
              ),
              margin: EdgeInsets.all(Screenadapter.height(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("手机"),
            ),
          ],
        ),
      ],
    );
  }

  //热销商品
  Widget _hotProduct() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: Screenadapter.height(138),
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/hot_search.png"),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(Screenadapter.width(20)),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true, //收缩
              itemCount: 8, //必须设置
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: Screenadapter.width(40),
                mainAxisSpacing: Screenadapter.height(20),
                childAspectRatio: 3 / 1,
              ),
              itemBuilder: ((context, index) {
                return Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: Screenadapter.width(120),
                      padding: EdgeInsets.all(Screenadapter.width(10)),
                      child: Image.network(
                        "https://www.itying.com/images/shouji.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(Screenadapter.width(10)),
                        alignment: Alignment.topLeft,
                        child: const Text("小米净化器 热水器 小米净化器"),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Container(
            width: Screenadapter.width(840),
            height: Screenadapter.height(96),
            decoration: BoxDecoration(
              color: Color.fromRGBO(246, 246, 246, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              style: TextStyle(fontSize: Screenadapter.fontSize(36)),
              //主动获取焦点
              // autofocus: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                controller.keywords = value;
              },
              //监听键盘回车
              onSubmitted: (value) {
                //保存搜索记录
                SearchServices.setHistoryData(controller.keywords);

                //替换路由,返回列表界面
                Get.offAndToNamed(
                  "/product-list",
                  arguments: {"keywords": controller.keywords},
                );
              },
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              //保存搜索记录
              SearchServices.setHistoryData(controller.keywords);

              Get.offAndToNamed(
                "/product-list",
                arguments: {"keywords": controller.keywords},
              );
            },
            child: Text("搜索", style: TextStyle(color: Colors.black)),
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(Screenadapter.height(50)),
        children: [
          _searchHistory(),
          _guessSearch(),
          SizedBox(height: Screenadapter.height(20)),
          _hotProduct(),
        ],
      ),
    );
  }
}
