import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../widgets/httpsClient.dart';
import '../../../widgets/signServices.dart';
import '../../../widgets/userServices.dart';
import '../../../models/order_model.dart';

class OrderInfoController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;
  var orderId = Get.arguments["id"];
  @override
  void onInit() {
    getOrderInfo();
    super.onInit();
  }

  //获取用户默认地址
  getOrderInfo() async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    UserModel userInfo = UserModel.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sId, "id": orderId};
    String sign = Signservices.getSign({
      ...tempJson,
      //私钥
      "salt": userInfo.salt,
    });

    var response = await httpsClient.get(
      "/api/orderInfo?uid=${userInfo.sId}&id=$orderId&sign=$sign",
    );
    print("=======${response.data}");
    if (response != null) {
      OrderModel tempOrderList = OrderModel.fromJson(response.data);
      orderList.value = tempOrderList.result!;
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
