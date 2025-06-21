import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/widgets/storage.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/httpsclient.dart';

class RegisterStepThreeController extends GetxController {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  //获取上个页面传递过来的手机号码和验证码
  String tel = Get.arguments["tel"];
  String code = Get.arguments["code"];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //执行注册
  Future<MessageModel> doRegister() async {
    var response = await httpsClient.post(
      "api/register",
      data: {"tel": tel, "password": passController.text, "code": code},
    );
    print(response);
    /* 
    {"success":true,"message":"注册成功","userinfo":[{"_id":"684d549ae8b3b000073c3c4b","username":"15213699369","tel":"15213699369","salt":"085fd9d1af6370fe093a8262a9fc3f7a","gold":88,"coupon":2,"redPacket":0,"quota":20,"collect":0,"footmark":0,"follow":0}]} */

    if (response != null) {
       print(response);
      if (response.data["success"]) {
       
        //z执行登录，保存用户信息
        Storage.setData("userinfo",response.data["userinfo"]);

        return MessageModel(message: "注册成功", success: true);
      }

      return MessageModel(message: response.data["success"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
