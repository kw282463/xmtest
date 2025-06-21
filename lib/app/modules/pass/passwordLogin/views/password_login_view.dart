import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message_model.dart';

import '../controllers/password_login_controller.dart';
import '../../../../widgets/screenAdapter.dart';
import '../../../../widgets/passButton.dart';
import '../../../../widgets/userAgreement.dart';
import '../../../../widgets/textFiled.dart';

import '../../../../widgets/logo.dart';

class PasswordLoginView extends GetView<PasswordLoginController> {
  const PasswordLoginView({super.key});
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
            controller: controller.telController,
            hintText: "请输入手机号码",
            onChanged: (value) {
              print(value);
            },
            keyboardType: TextInputType.number,
          ),
          PassTextField(
            controller: controller.passwordController,
            hintText: "请输入密码",
            onChanged: (value) {
              print(value);
            },
            keyboardType: TextInputType.text,
            isPassword: true,
          ),

          UserAgreement(),
          SizedBox(height: Screenadapter.height(80)),
          PassButton(
            onPressed: () async {
              //判断手机号
              if (!GetUtils.isPhoneNumber(controller.telController.text) &&
                  controller.telController.text.length != 11) {
                Get.snackbar("提示信息", "手机号码格式不符合");
              } else if (controller.passwordController.text.length < 6) {
                Get.snackbar("提示信息", "密码长度不能小于6位");
              } else {
                MessageModel result = await controller.doLogin();
                if (result.success) {
                  //执行跳转，返回到根目录
                  /*    Get.offAllNamed(
                    "/tabs",
                    arguments: {
                      "initialPage": 4, //跳转到用户界面
                    },
                  ); */
                  Get.back();
                } else {
                  Get.snackbar("提示信息", result.message);
                }
              }
            },
            text: "登录",
          ),
        ],
      ),
    );
  }
}
