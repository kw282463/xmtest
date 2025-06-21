import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/httpsclient.dart';

class RegisterStepOneController extends GetxController {
  TextEditingController? editingController = TextEditingController();

  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //发送验证码
  Future<MessageModel> sendCode() async {
    var response = await httpsClient.post(
      "api/sendCode",
      data: {"tel": editingController!.text},
    );
    print(response);
    //获取数据
    if (response != null) {
      if (response.data["success"]) {
        //将验证码复制到剪切板
        Clipboard.setData(ClipboardData(text: response.data["code"]));
        return MessageModel(message: "发送验证码成功", success: true);
      }
      return MessageModel(message: response.data["message"], success: false);
    } else {
      return MessageModel(message: "网络异常", success: false);
    }
  }
}
