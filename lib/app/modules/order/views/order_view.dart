import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/widgets/httpsClient.dart';

import '../../../widgets/screenAdapter.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text('订单'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(
            () =>
                controller.orderList.isNotEmpty
                    ? ListView(
                      padding: EdgeInsets.fromLTRB(
                        Screenadapter.width(20),
                        Screenadapter.height(140),
                        Screenadapter.width(20),
                        Screenadapter.width(20),
                      ),
                      children:
                          controller.orderList.map((value) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey[200]!),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed("/order-info",arguments: {
                                    "id":value.sId
                                  });
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("订单编号：${value.orderId}"),
                                    ),
                                    Column(
                                      children:
                                          value.orderItem!.map((e) {
                                            return ListTile(
                                              leading: Container(
                                                alignment: Alignment.center,
                                                width: Screenadapter.width(120),
                                                height: Screenadapter.width(
                                                  120,
                                                ),
                                                child: Image.network(
                                                  HttpsClient.replaceUri(
                                                    e.productImg!,
                                                  ),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                              title: Text("${e.productTitle}"),
                                              trailing: Text(
                                                "x${e.productCount}",
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                    ListTile(
                                      leading: Wrap(
                                        children: [
                                          Text("合计:"),
                                          Text(
                                            "￥${value.allPrice}",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ],
                                      ),
                                      trailing: TextButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                Colors.grey[200],
                                              ),
                                        ),
                                        child: const Text("申请售后"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    )
                    : Text("你还没有订单信息"),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: Colors.grey[50],
              width: Screenadapter.width(1080),
              height: Screenadapter.height(120),
              child: Row(
                children: const [
                  Expanded(child: Text("全部", textAlign: TextAlign.center)),
                  Expanded(child: Text("待付款", textAlign: TextAlign.center)),
                  Expanded(child: Text("待收货", textAlign: TextAlign.center)),
                  Expanded(child: Text("已完成", textAlign: TextAlign.center)),
                  Expanded(child: Text("已取消", textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
