import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/httpsClient.dart';
import '../../../../widgets/storage.dart';
import '../../../user/controllers/user_controller.dart';

class PasswordLoginController extends GetxController {
  TextEditingController telController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
    UserController userController = Get.find<UserController>();

 

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
      //页面销毁更新用户的信息
    userController.getUserInfo();
    print("更新用户状态");
    super.onClose();
  }

  Future<MessageModel> doLogin() async {
    var response = await httpsClient.post(
      "api/doLogin",
      data: {
        "username": telController.text,
        "password": passwordController.text,
      },
    );
    if (response != null) {
      print(response);
      if (response.data["success"]) {
        //z执行登录，保存用户信息
        Storage.setData("userinfo", response.data["userinfo"]);

        return MessageModel(message: "登录成功", success: true);
      }

      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
