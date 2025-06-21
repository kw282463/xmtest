/* import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterStepTwoController extends GetxController {
  TextEditingController? editingController = TextEditingController();
String tel=Get.arguments["tel"]
  //TODO: Implement RegisterStepTwoController
  // 验证验证码
  void verifyCode(String pin) {
    // 处理验证码逻辑
    if (pin == '222222') {
      Get.snackbar('成功', '验证码正确', backgroundColor: Colors.green);
      // 跳转到下一页
      Get.toNamed("/register-step-three");
    } else {
      Get.snackbar('错误', '验证码不正确', backgroundColor: Colors.red);
    }
  }

  // 重新发送验证码
  void resendCode() {
    // 实现重新发送逻辑
    Get.snackbar('提示', '验证码已重新发送', backgroundColor: Colors.blue);
  }
} */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/httpsclient.dart';

class RegisterStepTwoController extends GetxController {
  TextEditingController? editingController = TextEditingController();

  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  String tel = Get.arguments["tel"];
  final RxInt countdown = 60.obs; // 倒计时
  final RxBool canResend = true.obs; // 能否重新发送

  @override
  void onInit() {
    super.onInit();
    countDown();
  }

  // 验证验证码
  Future<bool> verifyCode() async {
    var response = await httpsClient.post(
      "api/validateCode",
      data: {
        "tel": tel, //上个页面传来的手机号
        "code": editingController!.text, //验证码
      },
    );
    print(response);
    //获取数据
    if (response != null) {
      if (response.data["success"]) {
        return true;
      }
      return false;
    } else {
      return false;
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
    var response = await httpsClient.post("api/sendCode", data: {"tel": tel});
    print(response);

    if (response != null) {
      if (response.data["success"]) {
        countdown.value = 60;
        canResend.value = false;
        Get.snackbar("提示！","已重新发送");
        countDown();
      } else {
        Get.snackbar("提示！", "非法请求");
      }
    } else {
      Get.snackbar("提示！", "网络异常");
    }
  }
}
