import 'package:get/get.dart';

import '../../../models/user_model.dart';
import '../../../widgets/httpsClient.dart';
import '../../../widgets/signServices.dart';
import '../../../widgets/userServices.dart';
import '../../../models/order_model.dart';

class OrderController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  RxList<OrderInfoModel> orderList = <OrderInfoModel>[].obs;


  @override
  void onInit() {
  getOrderlist();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //获取用户信息
  getOrderlist() async {
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
      "/api/orderList?uid=${userInfo.sId}&sign=$sign",
    );
    print("=======${response.data}");
   if (response != null) {
      OrderModel tempOrderList = OrderModel.fromJson(response.data);
      orderList.value = tempOrderList.result!;
      update();
    } 
  }
}
