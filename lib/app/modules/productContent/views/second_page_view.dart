import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screenAdapter.dart';
import '../controllers/product_content_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class SecondPageView extends GetView {
  final ProductContentController controller = Get.find();
  final Function subHeader;
  SecondPageView(this.subHeader, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.gk2,
      alignment: Alignment.center,
      width: Screenadapter.width(1080),
      child:Obx(() =>controller.pcontent.value.content!=null?  Column(
        children: [
          subHeader(),
          controller.selectedSubTabsIndex.value == 1
              ? SizedBox(
                  width: Screenadapter.width(1080),
                  child: Html(
                    data: controller.pcontent.value.content,
                    style: {
                      "body": Style(backgroundColor: Colors.white),
                      "p": Style(fontSize: FontSize.large),
                    },
                  ))
              : Container(
                  width: Screenadapter.width(1080),
                  child: Html(
                    data: controller.pcontent.value.specs,
                    style: {
                      "body": Style(backgroundColor: Colors.white),
                      "p": Style(fontSize: FontSize.large),
                    },
                  ),
                )
        ],
      ):Text(""))
    );
  }
}
