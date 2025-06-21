import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/passButton.dart';
import '../../../widgets/Screenadapter.dart';

import '../controllers/pay_controller.dart';

class PayView extends GetView<PayController> {
  const PayView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('去支付'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(Screenadapter.width(20)),
        children: [
          Obx(
            () => ListView.builder(
              itemCount: controller.payList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        controller.changePayList(index);
                      },
                      leading: Image.network(
                        controller.payList[index]["image"],
                      ),
                      title: Text("${controller.payList[index]["title"]}"),
                      trailing:
                          controller.payList[index]["chekced"]
                              ? Icon(Icons.check)
                              : Text(""),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: Screenadapter.height(200)),
          PassButton(
            text: "支付",
            onPressed: () {
              Get.toNamed("/order");
              // print("支付");
              if (controller.payType == 0) {
                print("支付宝支付");
              } else {
                print("微信支付");
              }
            },
          ),
        ],
      ),
    );
  }
}
