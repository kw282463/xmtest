import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/message_model.dart';
import '../../../../widgets/passButton.dart';
import '../../../../widgets/Screenadapter.dart';
import '../../../../widgets/logo.dart';
import '../controllers/code_login_step_two_controller.dart';
import 'package:pinput/pinput.dart';

class CodeLoginStepTwoView extends GetView<CodeLoginStepTwoController> {
  const CodeLoginStepTwoView({super.key});

  @override
  Widget build(BuildContext context) {
    // 定义验证码框的样式
    final defaultPinTheme = PinTheme(
      width: 56, //验证码输入框宽度
      height: 56,
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(5),
      ),

      /* 
//底部光标
decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey, // 默认底部边框颜色
        width: 2,
      ),
    ),
  ),

 */
    );
    /* 
//底部光标
final focusedPinTheme = defaultPinTheme.copyWith(
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.red, // 聚焦时光标颜色
        width: 2,
      ),
    ),
  ),
); */
    /*  
   //聚焦动画
   // 聚焦状态主题（边框颜色和圆角修改）
   final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );  */

    /*  
  //每次输入就会背景变灰色
  // 提交状态主题（背景色修改）
   final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );  */

    return Scaffold(
      appBar: AppBar(title: const Text('验证码登录'), centerTitle: true),
      body: ListView(
        children: [
          Column(
            children: [
              Logo(),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '请输入验证码',
                      style: TextStyle(fontSize: Screenadapter.fontSize(40)),
                    ),
                    Text(
                      '已发送至：',
                      style: TextStyle(fontSize: Screenadapter.fontSize(40)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // 使用 Pinput 组件
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40), //左右间距各40
                child: Pinput(
                  autofocus: true,
                  length: 6, // 验证码长度
                  defaultPinTheme: defaultPinTheme,
                  //绑定controller
                  controller: controller.editingController,

                  // focusedPinTheme: focusedPinTheme,

                  //  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true, //是否显示光标

                  errorTextStyle: TextStyle(
                    color: Colors.red, // 错误文本颜色
                    fontSize: 14, // 错误文本大小
                    height: 1.5, // 错误文本与输入框的间距
                  ),
                  onCompleted: (pin) async {
                    print("验证码：$pin");
                    //完成登录，跳转到用户页面
                    MessageModel result = await controller.doLogin();
                    if (result.success) {
                      //直接重新返回到根目录
                      //  Get.offAllNamed("/tabs", arguments: {"initialPage": 4});
                      //从哪里进来返回到哪里
                      Get.back(); //返回不会立即刷新用户信息，
                      //因为页面的init只触发一次，解决办法类似于cart，
                      //也可以在销毁时，重新更新用户信息
                      //去controller解决
                    } else {
                      Get.snackbar("提示信息", result.message);
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              // 重新发送按钮
              Obx(() {
                return controller.countdown.value > 0
                    ? TextButton(
                      onPressed: null,
                      child: Text(
                        '${controller.countdown.value}秒后可重新发送',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                    : TextButton(
                      onPressed:
                          controller.canResend.value
                              ? controller.sendCode
                              : null,
                      child: const Text('重新发送验证码'),
                    );
              }),
            ],
          ),
          PassButton(
            text: "登录",
            onPressed: () async {
              //完成登录，跳转到用户页面
              MessageModel result = await controller.doLogin();
              if (result.success) {
                Get.offAllNamed("/tabs", arguments: {"initialPage": 4});
              } else {
                Get.snackbar("提示信息", result.message);
              }
            },
          ),
        ],
      ),
    );
  }
}
