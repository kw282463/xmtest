import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class CartItemNumView extends GetView {
  final ProductContentController contentController=Get.find();
   CartItemNumView({Key? key}) : super(key: key);
  Widget _left() {
    return InkWell(
      onTap: () {
        contentController.dnNum();
      },
      child: Container(
        alignment: Alignment.center,
        width: Screenadapter.width(80),
        height: Screenadapter.height(80),
        child: const Text(
          "-",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.0),
        ),
      ),
    );
  }

  Widget _center() {
    return Obx(()=>Container(
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
      height: Screenadapter.height(80),
      child:  Text(
        "${contentController.buyNum.value}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, height: 1.0),
      ),
    ));
  }

  Widget _right() {
    return InkWell(
      onTap: () {
        contentController.upNum();
      },
      child: Container(
      alignment: Alignment.center,
      width: Screenadapter.width(80),
      height: Screenadapter.height(80),
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
      height: Screenadapter.height(80),
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
