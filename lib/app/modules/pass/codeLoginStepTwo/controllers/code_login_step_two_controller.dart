import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../user/controllers/user_controller.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/httpsclient.dart';
import '../../../../widgets/storage.dart';
import 'package:flutter/services.dart';

class CodeLoginStepTwoController extends GetxController {
  TextEditingController? editingController = TextEditingController();
  UserController userController = Get.find<UserController>();

  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  String tel = Get.arguments["tel"];
  final RxInt countdown = 10.obs; // 倒计时
  final RxBool canResend = true.obs; // 能否重新发送

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  @override
  void onClose() {
    //页面销毁更新用户的信息
    userController.getUserInfo();
    print("更新用户状态");
    super.onClose();
  }

  //执行登录
  Future<MessageModel> doLogin() async {
    var response = await httpsClient.post(
      "api/validateLoginCode",
      data: {"tel": tel, "code": editingController!.text},
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

  // 倒计时逻辑
  void countDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true; //重新启用按钮
        timer.cancel();
      }
    });
  }

  //重新发送验证码
  void sendCode() async {
    var response = await httpsClient.post(
      "api/sendLoginCode",
      data: {"tel": tel},
    );
    print(response);

    if (response != null) {
      if (response.data["success"]) {
        //将验证码复制到剪切板,正式上线需要删除
        Clipboard.setData(ClipboardData(text: response.data["code"]));

        countdown.value = 10;
        canResend.value = false;
        Get.snackbar("提示！", "已重新发送");
        countDown();
        update();
      } else {
        Get.snackbar("提示！", "非法请求");
      }
    } else {
      Get.snackbar("提示！", "网络异常");
    }
  }
}
