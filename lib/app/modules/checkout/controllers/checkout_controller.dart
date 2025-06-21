import 'dart:convert';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/cart/controllers/cart_controller.dart';
import 'package:xmshop/app/widgets/cartServices.dart';
import '../../../widgets/storage.dart';
import '../../../models/user_model.dart';
import '../../../widgets/httpsclient.dart';
import '../../../widgets/userServices.dart';
import '../../../widgets/signServices.dart';
import '../../../models/address_model.dart';

class CheckoutController extends GetxController {
  RxList checkoutList = [].obs;
  HttpsClient httpsClient = HttpsClient();
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;
  RxDouble allPrice = 0.0.obs;
  RxInt allNum = 0.obs;
  CartController cartController = Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    getCheckoutData();
    getDefaultAddress();
  }

  //获取checkListData的数据
  getCheckoutData() async {
    var tempList = await Storage.getData("checkListData");
    checkoutList.value = tempList;
    computedAllPrice();
    countNum();
    update();
  }

  //获取用户默认地址
  getDefaultAddress() async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sId};
    String sign = Signservices.getSign({
      ...tempJson,
      //私钥
      "salt": userInfo.salt,
    });

    var response = await httpsClient.get(
      "api/oneAddressList?uid=${userInfo.sId}&sign=$sign",
    );
    print("=======$response");
    if (response != null) {
      var tempAddressList = AddressModel.fromJson(response.data);
      addressList.value = tempAddressList.result!;
      update();
    }
  }

  //计算总价
  computedAllPrice() {
    double tempAllPrice = 0.0;
    for (var i = 0; i < checkoutList.length; i++) {
      if (checkoutList[i]["checked"] == true) {
        tempAllPrice += checkoutList[i]["price"] * checkoutList[i]["count"];
      }
    }
    allPrice.value = tempAllPrice;
  }

  //计算数量
  countNum() {
    int tempNum = 0;
    for (var i = 0; i < checkoutList.length; i++) {
      // 安全检查：确保 checked 为 true 且 count 不为 null
      if (checkoutList[i]["count"] != null) {
        // 将 num 类型转换为 int（舍去小数部分）
        tempNum += (checkoutList[i]["count"] as num).toInt();
        print(tempNum);
      }
    }
    allNum.value = tempNum; // 返回计算结果
  }

  //去结算
  doCheckout() async {
    if (addressList.isNotEmpty) {
      //获取用户信息
      List userList = await UserServices.getUserInfo();
      UserModel userInfo = UserModel.fromJson(userList[0]);
      Map tempJson = {
        "uid": userInfo.sId,
        "phone": addressList[0].phone,
        "address": addressList[0].address,
        "name": addressList[0].name,
        "all_price": allPrice.value.toStringAsFixed(1), //保留一位小数
        "products": json.encode(checkoutList),
      };
      String sign = Signservices.getSign({
        ...tempJson,
        //私钥
        "salt": userInfo.salt,
      });

      var response = await httpsClient.post(
        "api/doOrder",
        data: {...tempJson, "sign": sign},
      );
      print("===结算订单：====$response");
      if (response.data["success"]) {
        //提交成功后记得删除购物车中的商品
        await CartServices.deleteCheckOut(checkoutList);

        //更新购物车数据
        cartController.getCartListData();
        //跳转到支付页面
        Get.toNamed("/pay");
      } else {
        Get.snackbar("提示信息", response.data["message"]);
      }
    } else {
      Get.snackbar("提示信息", "请添加收货地址");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
