import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../models/focus_model.dart';
import '../../../models/category_model.dart';
import '../../../models/hot_model.dart';
import '../../../models/plist_model.dart';
import '../../../widgets/httpsclient.dart';

class HomeController extends GetxController {
  //浮动导航开关
  RxBool flag = false.obs;
  //滚动条高度
  final ScrollController scrollController = ScrollController();

  //接口轮播图
  RxList<FocusItemModel> swiperList =
      <FocusItemModel>[].obs; //定义成响应式数据（List也不会报错，但是后面数据要更新，只能是响应式）

  //接口分类图
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;

  //热销分类图
  RxList<HotItemModel> hotList = <HotItemModel>[].obs;
  //推荐分类图
  RxList<PlistItemModel> plistList = <PlistItemModel>[].obs;
  //瀑布流数据
  RxList<PlistItemModel> masonryList = <PlistItemModel>[].obs;
  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    super.onInit();
    //初始化方法
    scrollerControllerListener();
    //请求轮播图接口
    getFocusData();
    //请求分类家口
    getCategoryData();
    //请求热榜轮播图
    getHotData();
    //请求推荐轮播图
    getPlistData();
    //请求推荐轮播图
    getMasonryData();
  }

  //监听滚动条滚动事件

  void scrollerControllerListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10 &&
          scrollController.position.pixels < 20) {
        if (flag.value == false) {
          flag.value = true;
          update();
        }
      }
      if (scrollController.position.pixels < 10) {
        if (flag.value == true) {
          flag.value = false;
          update();
        }
      }
    });
  }

  //获取轮播图数据
  getFocusData() async {
    var response = await httpsClient.get("api/focus");
    // swiperList.value=response.data["result"];
    //获取数据
    if (response != null) {
      var focus = FocusModel.fromJson(response.data);
      swiperList.value = focus.result!;

      update();
    }
  }

  //获取分类图数据
  getCategoryData() async {
    var response = await httpsClient.get("api/bestCate");
    // swiperList.value=response.data["result"];
    //获取数据
    if (response != null) {
      var category = CategoryModel.fromJson(response.data);
      categoryList.value = category.result!;

      update();
    }
  }

  //获取热销图数据
  getHotData() async {
    var response = await httpsClient.get("api/focus?position=2");
    // swiperList.value=response.data["result"];
    //获取数据
    if (response != null) {
      var hot = HotModel.fromJson(response.data);
      hotList.value = hot.result!;

      update();
    }
  }

  //获取推荐数据
  getPlistData() async {
    var response = await httpsClient.get("api/plist?is_hot=1");
    // swiperList.value=response.data["result"];
    //获取数据
    if (response != null) {
      var plist = PlistModel.fromJson(response.data);
      plistList.value = plist.result!;

      update();
    }
  }

  //获取瀑布流数据
  getMasonryData() async {
    var response = await httpsClient.get("api/plist?is_best=1");
    // swiperList.value=response.data["result"];
    //获取数据
    if (response != null) {
      var masonry = PlistModel.fromJson(response.data);
      masonryList.value = masonry.result!;

      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
