import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../models/plist_model.dart';
import '../../../widgets/httpsClient.dart';

class ProductListController extends GetxController {
  RxList<PlistItemModel> plist = <PlistItemModel>[].obs;
  //监听滚动条
  ScrollController scrollController = ScrollController();
  HttpsClient httpsClient = HttpsClient();
  GlobalKey<ScaffoldState> scaffoldGlobalKey =
      GlobalKey<ScaffoldState>(); //绑定key

  //请求页数
  int page = 1;
  int pageSize = 8;
  bool flag = true;
  RxBool hasData = true.obs;
  //排序
  String sort = "";
  //获取传值
  String? keywords = Get.arguments["keywords"];
  String? cid = Get.arguments["cid"];
  String apiUri = "";

  //二级导航数据
  List subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"},
  ];
  //二级当行选中判断
  RxInt selectHeaderId = 1.obs;

  //解决一致按图标不会改变
  RxInt subheadSort = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getPlistData();
    initScrillController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getPlistData() async {
    if (flag && hasData.value) {
      flag = false;
      if (cid != null) {
        apiUri =
            "api/plist?cid=$cid&page=${page}&pageSize=$pageSize&sort=$sort";
      } else {
        apiUri =
            "api/plist?search=$keywords&page=${page}&pageSize=$pageSize&sort=$sort";
      }
      print(apiUri);
      var response = await httpsClient.get(apiUri);
      //获取数据
      if (response != null) {
        var product = PlistModel.fromJson(response.data);
        //拼接数据
        //  plist.value = product.result!;
        plist.addAll(product.result!);
        page++;
        update();
        flag = true;
        if (product.result!.length < pageSize) {
          hasData.value = false;
        }
      }
    }
  }

  //监听滚动条事件
  void initScrillController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20) {
        getPlistData();
      }
    });
  }

  //二级导航改变触发
  void subHeadChange(id) {
    if (id == 4) {
      //打开侧边栏
      scaffoldGlobalKey.currentState!.openEndDrawer();
    } else {
      selectHeaderId.value = id;
      //改变排序，重新请求
      sort =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      //切换排序
      subHeaderList[id - 1]["sort"] = subHeaderList[id - 1]["sort"] * -1;
      subheadSort.value = subHeaderList[id - 1]["sort"];

      //重置page
      page = 1;
      //重置数据
      plist.value = [];
      //重置hasData
      hasData.value = true;
      //滚动条回到顶部
      scrollController.jumpTo(0);
      //重新请求接口
      getPlistData();
    }
  }
}
