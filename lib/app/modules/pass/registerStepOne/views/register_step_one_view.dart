import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/logo.dart';

import '../../../../widgets/passButton.dart';
import '../../../../widgets/textFiled.dart';
import '../controllers/register_step_one_controller.dart';

class RegisterStepOneView extends GetView<RegisterStepOneController> {
  const RegisterStepOneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册第一步'), centerTitle: true),
      body: ListView(
        children: [
          Logo(),
          PassTextField(
            controller: controller.editingController,
            onChanged: (value) {},
            hintText: "请输入手机号",
            keyboardType: TextInputType.number,
          ),

          PassButton(
            onPressed: () async {
              if (GetUtils.isPhoneNumber(controller.editingController!.text) &&
                  (controller.editingController!.text.length == 11)) {
                MessageModel result = await controller.sendCode();
                if (result.success) {
                  Get.toNamed("/register-step-two",arguments: {
                    "tel":controller.editingController!.text
                  });
                } else {
                  Get.snackbar("提示信息", result.message);
                }
              } else {
                Get.snackbar("提示信息", "手机号码格式不正确");
              }
            },
            text: "下一步",
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("遇到问题？您可以"),
                TextButton(onPressed: () {}, child: Text("获取帮助")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
