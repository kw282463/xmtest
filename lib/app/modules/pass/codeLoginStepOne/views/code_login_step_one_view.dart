import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../models/message_model.dart';
import '../../../../widgets/passButton.dart';
import '../../../../widgets/userAgreement.dart';

import '../../../../widgets/logo.dart';
import '../../../../widgets/screenAdapter.dart';
import '../../../../widgets/textFiled.dart';

import '../controllers/code_login_step_one_controller.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('验证码'),
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
            onChanged: (value) {},
            keyboardType: TextInputType.number,
          ),
          UserAgreement(),
          SizedBox(height: Screenadapter.height(40)),
          PassButton(
            onPressed: () async {
              //判断手机号
              if (!GetUtils.isPhoneNumber(controller.telController.text) &&
                  controller.telController.text.length != 11) {
                Get.snackbar("提示信息", "手机号码格式不符合");
              } else {
                MessageModel result = await controller.sendCode();
                if (result.success) {
                  //执行跳转，返回到根目录，直接跳转
                  /*  Get.toNamed(
                    "/code-login-step-two",
                    arguments: {"tel": controller.telController.text},
                  ); */
                  //替换路由，下个界面返回就是从哪里进来返回到哪里
                  Get.offAndToNamed(
                    "/code-login-step-two",
                    arguments: {"tel": controller.telController.text},
                  );
                } else {
                  Get.snackbar("提示信息", result.message);
                }
              }
            },

            /*     onPressed: () {
              Get.toNamed("/code-login-step-two");
            }, */
            text: "获取验证码",
          ),
          SizedBox(height: Screenadapter.height(40)),
          //新用户注册/账号密码登录
          Container(
            padding: EdgeInsets.all(Screenadapter.height(30)),
            margin: EdgeInsets.symmetric(horizontal: Screenadapter.width(60)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  //不要颜色，只要点击点击动画
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.toNamed("/register-step-one");
                  },
                  child: Text(
                    "新用户注册",
                    style: TextStyle(
                      fontSize: Screenadapter.fontSize(34),
                      color: Colors.grey,
                    ),
                  ),
                ),
                InkWell(
                  //不要颜色，只要点击点击动画
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                   // Get.toNamed("/password-login");
                   //替换路由
                    Get.offAndToNamed("/password-login");
                  },
                  child: Text(
                    "账户密码登录",
                    style: TextStyle(
                      fontSize: Screenadapter.fontSize(34),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
