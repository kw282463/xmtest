import 'package:get/get.dart';
import 'package:xmshop/app/widgets/storage.dart';
import './../../../widgets/searchServices.dart';

class SearchsController extends GetxController {
  String keywords = "";
  RxList historyList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getHistoryData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //获取历史数据
  getHistoryData() async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      historyList.addAll(tempList);
      update();
    }
  }

  //删除历史数据
  clearHistoryData() async {
    SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }

  //双击删除指定数据
  deleteHistoryData(keywords) async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      tempList.remove(keywords);
      //重新写入
      await Storage.setData("searchList", tempList);

      // 更新状态
      historyList.remove(keywords); // 直接赋值更新整个列表
      update();
    }
  }
}
