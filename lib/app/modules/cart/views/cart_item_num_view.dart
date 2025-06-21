import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screenAdapter.dart';
import '../controllers/cart_controller.dart';

class CartItemNumView extends GetView {
  final CartController controller = Get.find();
  final Map cartItem;
  CartItemNumView(this.cartItem, {Key? key}) : super(key: key);
  Widget _left() {
    return InkWell(
      onTap: () {
        controller.dnCartNum(cartItem);
      },
      child: Container(
        alignment: Alignment.center,
        width: Screenadapter.width(80),
        height: Screenadapter.height(64),
        child: const Text(
          "-",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.0),
        ),
      ),
    );
  }

  Widget _center() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: Screenadapter.width(2),
            color: Colors.black12,
          ),
          right: BorderSide(
            width: Screenadapter.width(2),
            color: Colors.black12,
          ),
        ),
      ),
      alignment: Alignment.center,
      width: Screenadapter.width(80),
      height: Screenadapter.height(64),
      child: Text(
        "${cartItem["count"]}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, height: 1.0),
      ),
    );
  }

  Widget _right() {
    return InkWell(
      onTap: () {
        controller.upCartNum(cartItem);
      },
      child: Container(
        alignment: Alignment.center,
        width: Screenadapter.width(80),
        height: Screenadapter.height(64),
        child: const Text(
          "+",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screenadapter.width(244),
      height: Screenadapter.height(66),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Screenadapter.height(20)),
        border: Border.all(
          width: Screenadapter.width(2),
          color: Colors.black12,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_left(), _center(), _right()],
      ),
    );
  }
}
