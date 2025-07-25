import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/order_model.dart';
import 'package:xmshop/app/widgets/httpsClient.dart';

import '../../../widgets/screenAdapter.dart';
import '../controllers/order_info_controller.dart';

class OrderInfoView extends GetView<OrderInfoController> {
  Widget _orderItem(OrderItemModel value) {
    return Container(
      padding: EdgeInsets.only(
        top: Screenadapter.height(20),
        bottom: Screenadapter.height(20),
        right: Screenadapter.height(20),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: Screenadapter.width(200),
            height: Screenadapter.width(200),
            padding: EdgeInsets.all(Screenadapter.width(20)),
            child: Image.network(
              HttpsClient.replaceUri("${value.productImg}"),
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${value.productTitle}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Screenadapter.height(10)),
                Text("${value.selectedAttr}"),
                SizedBox(height: Screenadapter.height(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "￥${value.productPrice}",
                      style: TextStyle(color: Colors.red),
                    ),
                    Text(
                      "x${value.productCount}",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  const OrderInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Text('订单详情'),
        centerTitle: true,
      ),
      body: Obx(
        () =>
            controller.orderList.isNotEmpty
                ? ListView(
                  padding: EdgeInsets.all(Screenadapter.width(40)),
                  children: [
                    //商品信息
                    Container(
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(20),
                        bottom: Screenadapter.height(20),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Screenadapter.width(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "商品信息",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ...controller.orderList[0].orderItem!.map((value) {
                            return _orderItem(value);
                          }).toList(),
                        ],
                      ),
                    ),
                    //订单信息
                    SizedBox(height: Screenadapter.height(40)),
                    Container(
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(20),
                        bottom: Screenadapter.height(20),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Screenadapter.width(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "订单信息",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "订单编号：${controller.orderList[0].orderId}",
                            ),
                          ),
                          ListTile(
                            title: Text(
                              //将时间戳转化为日期
                              "下单时间：${DateTime.fromMillisecondsSinceEpoch(controller.orderList[0].addTime!)}",
                            ),
                          ),
                          ListTile(title: Text("支付方式:微信支付")),
                          /*   ListTile(
                  title: Text("支付时间：${controller.orderList[0].orderId}"),
                ), */
                        ],
                      ),
                    ),
                    SizedBox(height: Screenadapter.height(40)),
                    //配送信息
                    Container(
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(20),
                        bottom: Screenadapter.height(20),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Screenadapter.width(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "配送信息",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(title: Text("配送方式：圆通快递")),
                          ListTile(
                            title: Text(
                              "收货人:${controller.orderList[0].name} ${controller.orderList[0].phone}",
                            ),
                          ),
                          ListTile(
                            title: Text("${controller.orderList[0].address}"),
                          ),
                          ListTile(
                            title: Text("期望配送时间:2025-11-13  9:00-21:00"),
                          ),
                        ],
                      ),
                    ),
                    //支付金额
                    SizedBox(height: Screenadapter.height(40)),
                    Container(
                      padding: EdgeInsets.only(
                        top: Screenadapter.height(20),
                        bottom: Screenadapter.height(20),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          Screenadapter.width(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("商品总额"),
                            trailing: Text(
                              "¥${controller.orderList[0].allPrice}",
                            ),
                          ),
                          ListTile(title: Text("运费"), trailing: Text("¥0元")),
                          ListTile(
                            trailing: Text(
                              "实付款 ¥${controller.orderList[0].allPrice}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
