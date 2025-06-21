import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/widgets/httpsClient.dart';
import '../../..//widgets/screenAdapter.dart';
import '../controllers/home_controller.dart';
import '../../../widgets/keepAliveWrapper.dart';
import '../../../widgets/myFonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  //顶部导航
  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() {
        return AppBar(
          leading:
              controller.flag.value
                  ? const Text("")
                  : Icon(MyFonts.xiaomi, color: Colors.white),

          //定于一图标宽度，解决动画效果
          leadingWidth:
              controller.flag.value
                  ? Screenadapter.width(20)
                  : Screenadapter.width(140),
          title: InkWell(
            child: AnimatedContainer(
            width:
                controller.flag.value
                    ? Screenadapter.width(800)
                    : Screenadapter.width(620),
            height: Screenadapter.height(96),
            decoration: BoxDecoration(
              color: Color.fromARGB(237, 252, 243, 236),
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
                  "手机",
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
          backgroundColor:
              controller.flag.value
                  ? Colors.white
                  : Colors.transparent, //将状态栏改为透明
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.qr_code,
                color: controller.flag.value ? Colors.black : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                color: controller.flag.value ? Colors.black : Colors.white,
              ),
            ),
          ],
        );
      }),
    );
  }

  //轮播图
  Widget _focus() {
    return SizedBox(
      width: Screenadapter.width(1080),
      height: Screenadapter.height(682),
      child: Obx(() {
        //用obs来响应时加载数据渲染
        return Swiper(
          itemBuilder: (context, index) {
            return Image.network(
              HttpsClient.replaceUri("${controller.swiperList[index].pic}"),
              fit: BoxFit.cover,
            );
          },
          itemCount: controller.swiperList.length, //轮播图数量
          //修改轮播图下方的提示器
          pagination: const SwiperPagination(builder: SwiperPagination.rect),
          autoplay: true, //自己轮播
          loop: true, //无限轮播
          duration: 500, //毫秒
          //  control: const SwiperControl(),//轮播图加上箭头
        );
      }),
    );
  }

  //banner
  Widget _banner() {
    return SizedBox(
      height: Screenadapter.height(92),
      width: Screenadapter.width(1080),
      child: Image.asset("assets/images/xiaomiBanner.png", fit: BoxFit.cover),
    );
  }

  //banner2
  Widget _banner2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Screenadapter.width(20),
        Screenadapter.width(20),
        Screenadapter.width(20),
        0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Screenadapter.width(20)),
          image: DecorationImage(
            image: AssetImage("assets/images/xiaomiBanner2.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: Screenadapter.height(420),
      ),
    );
  }

  //顶部滑动的分类
  Widget _category() {
    return SizedBox(
      width: Screenadapter.width(1080),
      height: Screenadapter.height(500),

      // color: Colors.blue,
      child: Obx(
        () => Swiper(
          itemBuilder: (context, index) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(), //进制上下滚动
              padding: EdgeInsets.zero, // 移除 GridView 自身的内边距
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: Screenadapter.width(20),
                mainAxisSpacing: Screenadapter.height(20),
              ),
              itemBuilder: (context, i) {
            
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: Screenadapter.width(140),
                      height: Screenadapter.height(140),
                      child: Image.network(
                       HttpsClient.replaceUri("${controller.categoryList[index * 10 + i].pic}"), //替换
                        fit: BoxFit.cover,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        Screenadapter.height(4),
                        0,
                        0,
                      ),
                      child: Text(
                        "${controller.categoryList[index * 10 + i].title}",
                        style: TextStyle(fontSize: Screenadapter.fontSize(34)),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          itemCount: controller.categoryList.length ~/ 10, //轮播图数量,根据数据取整
          //修改轮播图下方的提示器
          /* pagination: const SwiperPagination(//默认的指示器
                builder: SwiperPagination.rect,
              ), */

          //  control: const SwiperControl(),//轮播图加上箭头

          //自定义指示器
          pagination: SwiperPagination(
            margin: const EdgeInsets.all(0.0),
            builder: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
                return ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: Screenadapter.height(40),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: const RectSwiperPaginationBuilder(
                            color: Colors.black12,
                            activeColor: Colors.black45,
                          ).build(context, config),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //热销
  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            Screenadapter.width(30),
            Screenadapter.height(20),
            Screenadapter.width(30),
            Screenadapter.height(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "热销甄选",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(46),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "更多推荐 >",
                style: TextStyle(fontSize: Screenadapter.fontSize(42)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            Screenadapter.width(30),
            0,
            Screenadapter.width(30),
            Screenadapter.height(20),
          ),
          child: Row(
            children: [
              //左边
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: Screenadapter.height(900),
                  //color: Colors.red[100],
                  child: Obx(
                    () => Swiper(
                      itemBuilder: (context, index) {
                       
                        return Image.network(
                          HttpsClient.replaceUri("${controller.hotList[index].pic}"),
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: controller.hotList.length, //轮播图数量
                      //修改轮播图下方的提示器
                      pagination: const SwiperPagination(
                        builder: SwiperPagination.rect,
                      ),
                      autoplay: true, //自己轮播
                      loop: true, //无限轮播
                      duration: 500, //毫秒
                      //  control: const SwiperControl(),//轮播图加上箭头
                    ),
                  ),
                ),
              ),
              SizedBox(width: Screenadapter.width(20)),

              //右边
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: Screenadapter.height(900),
                  // color: Colors.blue,
                  child: Obx(
                    () => Column(
                      children:
                          controller.plistList.asMap().entries.map((entries) {
                            //吧map转化为asmap，解决左后一个也要高20
                            var value = entries.value;
                            //entries.value是每一行的值
                  
                            return //上
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: const Color.fromARGB(255, 249, 244, 244),
                                margin: EdgeInsets.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  entries.key == 2
                                      ? 0
                                      : Screenadapter.height(20),
                                ), //每一行都间隔20，但是会出现最后一个他也会高20.解决后，判断
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //左
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Text(
                                            "${value.title}",
                                            style: TextStyle(
                                              fontSize: Screenadapter.fontSize(
                                                38,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Screenadapter.height(10),
                                          ),
                                          Text(
                                            "${value.subTitle}",
                                            style: TextStyle(
                                              fontSize: Screenadapter.fontSize(
                                                28,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Screenadapter.height(10),
                                          ),
                                          Text(
                                            "${value.price}元起",
                                            style: TextStyle(
                                              fontSize: Screenadapter.fontSize(
                                                34,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //右
                                    Expanded(
                                      flex: 2,
                                      child: Image.network(
                                      HttpsClient.replaceUri("${value.pic}"),

                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //瀑布列表
  Widget _bestGood() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            Screenadapter.width(30),
            Screenadapter.height(20),
            Screenadapter.width(30),
            Screenadapter.height(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "省心优惠",
                style: TextStyle(
                  fontSize: Screenadapter.fontSize(46),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "全部优惠 >",
                style: TextStyle(fontSize: Screenadapter.fontSize(42)),
              ),
            ],
          ),
        ),
        Container(
          // color: const Color.fromARGB(255, 249, 244, 244),
          padding: EdgeInsets.all(Screenadapter.width(10)),
         // color: Colors.blue,
          child: Obx(
            () => MasonryGridView.count(
              padding: EdgeInsets.zero, //移除GridView自身的内边距，不然会元素距离顶部有一段距离
              crossAxisCount: 2, //多少列
              mainAxisSpacing: Screenadapter.width(30), //行间距
              crossAxisSpacing: Screenadapter.width(30),
              itemCount: controller.masonryList.length, //多少个元素
              // itemExtent: 150,//每个元素的高度
              shrinkWrap: true, //解决无限高度问题，是元素自适应
              physics: NeverScrollableScrollPhysics(), //禁止 滚动，外部是listView
              itemBuilder: (context, index) {
                return InkWell(
                  //跳转详情
                  onTap: () {
                    Get.toNamed("/product-content",arguments: {
                      "id":controller.masonryList[index].sId
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        //  child: Image.network(picUrl.replaseAll("\\","/"),fit:Boxfit.cover),
                        child: Image.network(
                         HttpsClient.replaceUri("${controller.masonryList[index].pic}"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "${controller.masonryList[index].title}",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(36),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "${controller.masonryList[index].subTitle}",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(28),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "￥${controller.masonryList[index].price}",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(28),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  //内部区域
  Widget _body() {
    return ListView(
      controller: controller.scrollController, //绑定监听
      padding: EdgeInsets.only(
        top: 0, // 避免 AppBar 遮挡内容
      ),
      children: [
        _focus(),
        _banner(),
        _category(),
        _banner2(),
        _bestSelling(),
        _bestGood(),
      ],
    );
    //  "https://www.itying.com/images/focus/focus02.png",
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(body: Stack(children: [_body(), _appBar()])), //注意顺序
    );
  }
}
