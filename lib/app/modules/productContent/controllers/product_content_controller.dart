import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xmshop/app/widgets/storage.dart';
import '../../../models/pcontent_model.dart';
import '../../../widgets/httpsClient.dart';
import '../../../widgets/Screenadapter.dart';
import '../../../widgets/cartServices.dart';
import '../../../widgets/userServices.dart';

class ProductContentController extends GetxController {
  final ScrollController scrollController = ScrollController();
  HttpsClient httpsClient = HttpsClient();
  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();
  //导航的透明度
  RxDouble opcity = 0.0.obs;
  //是否显示tabs
  RxBool showTabs = false.obs;

  //详情数据
  var pcontent = PcontentItemModel().obs;

  List tabsList = [
    {"id": 1, "title": "商品"},
    {"id": 2, "title": "详情"},
    {"id": 3, "title": "推荐"},
  ];
  RxInt selectedTabsIndex = 1.obs;
  //attr
  RxList<PcontentAttrModel> pcontentAttr = <PcontentAttrModel>[].obs;

  //Container的位置
  double gk2Position = 0;
  double gk3Position = 0;
  //是否显示详情tab切换
  RxBool showSubHeader = false.obs;

  List subTabList = [
    {"id": 1, "title": "商品详情"},
    {"id": 2, "title": "规格参数"},
  ];
  RxInt selectedSubTabsIndex = 1.obs;

  //保存筛选属性
  RxString selectedAttr = "".obs;

  //购买数量
  RxInt buyNum = 1.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getContentData();
  }

  //监听滚动条滚动事件
  void scrollControllerListener() {
    scrollController.addListener(() {
      //获取选然后元素的位置
      if (gk2Position == 0 && gk3Position == 0) {
        //获取Container的高度是获取距离顶部的高度，如果要从零计算，要加上下拉滚动高度
        getContainerPosition(scrollController.position.pixels);
      }
      //显示隐藏详情tab切换
      if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (showSubHeader.value == false) {
          showSubHeader.value = true;
          selectedTabsIndex.value = 2;
          update();
        }
      } else if (scrollController.position.pixels > 0 &&
          scrollController.position.pixels < gk2Position) {
        if (showSubHeader.value == true) {
          showSubHeader.value = false;
          selectedTabsIndex.value = 1;
          update();
        }
      } else if (scrollController.position.pixels > gk2Position) {
        if (showSubHeader.value == true) {
          showSubHeader.value = false;
          selectedTabsIndex.value = 3;
          update();
        }
      }

      //显示隐藏顶部tab切换
      if (scrollController.position.pixels <= 120) {
        opcity.value = scrollController.position.pixels / 100;
        print("---------------${opcity.value}");
        if (opcity.value > 0.97) {
          opcity.value = 1;
        }
        if (showTabs.value == true) {
          showTabs.value = false;
        }
        update();
      } else {
        if (showTabs.value == false) {
          showTabs.value = true;
          update();
        }
      }
    });
  }

  //获取元素的位置
  getContainerPosition(pixels) {
    RenderBox box2 = gk2.currentContext!.findRenderObject() as RenderBox;
    gk2Position =
        box2.localToGlobal(Offset.zero).dy +
        pixels -
        (Screenadapter.getStatusBarHeight() + Screenadapter.height(160));

    RenderBox box3 = gk3.currentContext!.findRenderObject() as RenderBox;
    gk3Position =
        box3.localToGlobal(Offset.zero).dy +
        pixels -
        (Screenadapter.getStatusBarHeight() + Screenadapter.height(160));

    print(gk2Position);
    print(gk3Position);
  }

  @override
  void onClose() {
    super.onClose();
  }

  //改变顶部tab切换
  void changeSelectedTabsIndex(index) {
    selectedTabsIndex.value = index;
    update();
  }

  //改变详情内容tab切换
  void changeSelectedSubTabsIndex(index) {
    selectedSubTabsIndex.value = index;
    //跳转到指定位置
    scrollController.jumpTo(gk2Position);
    update();
  }

  //获取详情数据
  getContentData() async {
    var response = await httpsClient.get(
      "api/pcontent?id=${Get.arguments["id"]}",
    );
    if (response != null) {
      print(response.data);
      var tempData = PcontentModel.fromJson(response.data);
      pcontent.value = tempData.result!;
      pcontentAttr.value = pcontent.value.attr!;
      initAttr(pcontentAttr);
      //获取商品属性
      getSelectedAttr();
      update();
    }
  }

  //初始化attr
  initAttr(List<PcontentAttrModel> attr) {
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        if (j == 0) {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": true});
        } else {
          attr[i].attrList!.add({"title": attr[i].list![j], "checked": false});
        }
      }
    }
  }

  //cate  颜色    title 玫瑰红
  changeAttr(cate, title) {
    for (var i = 0; i < pcontentAttr.length; i++) {
      if (pcontentAttr[i].cate == cate) {
        for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {
          pcontentAttr[i].attrList![j]["checked"] = false;
          if (pcontentAttr[i].attrList![j]["title"] == title) {
            pcontentAttr[i].attrList![j]["checked"] = true;
          }
        }
      }
    }
    update();
  }

  //获取Attr
  getSelectedAttr() {
    List tempList = [];
    for (var i = 0; i < pcontentAttr.length; i++) {
      for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {
        if (pcontentAttr[i].attrList![j]["checked"]) {
          tempList.add(pcontentAttr[i].attrList![j]["title"]);
        }
      }
    }
    selectedAttr.value = tempList.join(",");
    update();
  }

  //增加数量
  upNum() {
    buyNum.value++;
    update();
  }

  //减少数量
  dnNum() {
    if (buyNum > 1) {
      buyNum.value--;
    }
    update();
  }

  //添加购物车
  addCart() {
    getSelectedAttr();
    CartServices.addCart(pcontent.value, selectedAttr.value, buyNum.value);
    Get.back();
    Get.snackbar("提示！", "加入购物车成功");
  }

  //获取用户是否登录状态
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  //添加购物车
  void buy() async {
    getSelectedAttr();
    Get.back();
    //立即购买跳转到结算页面
    //1.判断是否登录
    bool loginState = await isLogin();
    if (loginState) {
      //保存商品信息
      List tempList = [];
      tempList.add({
        "_id": pcontent.value.sId,
        "title": pcontent.value.title,
        "price": pcontent.value.price,
        "selectedAttr": selectedAttr.value,
        "count": buyNum.value,
        "pic": pcontent.value.pic,
        "checked": true,
      });
      Storage.setData("checkListData", tempList);
      Get.toNamed("/checkout");
    } else {
      //没有登录跳转到登陆面
      Get.snackbar("提示信息", "请先登录");
      Get.toNamed("/code-login-step-one");
    }
  }

  /*   
    [{cate: 颜色, list: [土豪金, 玫瑰红, 磨砂黑]}, {cate: 内存, list: [16G, 32G, 64G]}]


    [
      {
        cate: 颜色, 
        list: [
          {
            title:土豪金,
            checked:true
          },
          {
            title:玫瑰红,
            checked:false
          },{
            title:磨砂黑,
            checked:false

          }
        ]
      },
      {cate: 内存, 
      list: [
          {
             title:16G,
            checked:true        
          },
           {
             title:32G,
            checked:false        
          }
      ]}

    ]
  */
}
