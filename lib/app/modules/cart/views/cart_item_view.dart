import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/screenAdapter.dart';
import '../views/cart_item_num_view.dart';
import '../../../widgets/httpsClient.dart';
import '../controllers/cart_controller.dart';

class CartItemView extends GetView {
  final Map cartItem;
  @override
  final CartController controller = Get.put(CartController());
   CartItemView(this.cartItem, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Screenadapter.height(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(178, 240, 236, 236),
            width: Screenadapter.height(2),
          ),
        ),
      ),
      child: Row(
        children: [
          //单选按钮
          SizedBox(
            width: Screenadapter.width(100),
            child: Checkbox(
              activeColor: Colors.red,
              value: cartItem["checked"],
              onChanged: (value) {
                controller.checkCartItem(cartItem);
              },
            ),
          ),
          Container(
            width: Screenadapter.width(260),
            padding: EdgeInsets.all(Screenadapter.height(24)),
            margin: EdgeInsets.only(right: Screenadapter.width(20)),
            child: Image.network(
            HttpsClient.replaceUri("${cartItem["pic"]}"),
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cartItem["title"]}",
                  style: TextStyle(
                    fontSize: Screenadapter.fontSize(36),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Screenadapter.height(20)),
                Row(children:  [Chip(label: Text("${cartItem["selectedAttr"]}"))]),
                SizedBox(height: Screenadapter.height(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "¥${cartItem["price"]}",
                      style: TextStyle(
                        fontSize: Screenadapter.fontSize(38),
                        color: Colors.red,
                      ),
                    ),
                     CartItemNumView(cartItem),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
