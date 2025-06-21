import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../models/message_model.dart';

import '../controllers/register_step_three_controller.dart';
import '../../../../widgets/screenAdapter.dart';
import '../../../../widgets/passButton.dart';
import '../../../../widgets/userAgreement.dart';
import '../../../../widgets/textFiled.dart';

import '../../../../widgets/logo.dart';

class RegisterStepThreeView extends GetView<RegisterStepThreeController> {
  const RegisterStepThreeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('账户密码登录'),
        centerTitle: true,
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: ListView(
        padding: EdgeInsets.all(Screenadapter.width(20)),
        children: [
          Logo(),
          PassTextField(
            controller: controller.passController,
            hintText: "请输入密码",
            isPassword: true,
            onChanged: (value) {},
            keyboardType: TextInputType.text,
          ),
          PassTextField(
            controller: controller.confirmController,
            hintText: "请确认输入密码",
            onChanged: (value) {},
            keyboardType: TextInputType.text,
            isPassword: true,
          ),

          UserAgreement(),
          SizedBox(height: Screenadapter.height(80)),
          PassButton(
            onPressed: () async {
              if (controller.passController.text !=
                  controller.confirmController.text) {
                Get.snackbar("提示信息", "密码不一致！");
              } else if (controller.passController.text.length < 6) {
                Get.snackbar("提示信息", "密码不能低于六位！");
              } else {
                MessageModel result = await controller.doRegister();
                if (result.success) {
                  //执行跳转 回到根目录
                  Get.offAllNamed(
                    "/tabs",
                    arguments: {
                      "initialPage": 4, //注册完成跳转到用户页面
                    },
                  );
                } else {
                  Get.snackbar("提示信息", result.message);
                }
              }
            },
            text: "完成注册",
          ),
        ],
      ),
    );
  }
}
