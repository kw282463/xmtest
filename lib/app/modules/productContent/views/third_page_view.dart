import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class ThirdPageView extends GetView {
  final ProductContentController contentController = Get.find();
  ThirdPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      key: contentController.gk3,
      alignment: Alignment.center,
      width: Screenadapter.width(1080),
      height: Screenadapter.height(2500),
      color: Colors.orange,
      child: const Text("推荐", style: TextStyle(fontSize: 100)),
    );
  }
}
