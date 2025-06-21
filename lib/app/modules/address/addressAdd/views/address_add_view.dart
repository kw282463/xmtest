import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../widgets/screenAdapter.dart';

import '../controllers/address_add_controller.dart';
import 'package:city_pickers/city_pickers.dart';

class AddressAddView extends GetView<AddressAddController> {
  const AddressAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新建收货地址'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(Screenadapter.width(50)),
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("姓 名:"),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: Screenadapter.fontSize(38),
                                ),

                                hintText: "请输入姓名",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.5),
                      Row(
                        children: [
                          Text("电 话:"),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                             controller: controller.phoneController,

                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: Screenadapter.fontSize(38),
                                ),

                                hintText: "请输入手机号码",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 0.5),
                    ],
                  ),
                ),
                SizedBox(height: Screenadapter.height(80)),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "所在地区:",
                            style: TextStyle(
                              fontSize: Screenadapter.fontSize(38),
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () async {
                                //点击弹出城市选择筛选
                                Result? result =
                                    await CityPickers.showCityPicker(
                                      height: Screenadapter.height(800),
                                      theme: ThemeData(
                                        primaryColor: Colors.white,
                                      ),
                                      context: context,
                                      confirmWidget: Text("确认"),
                                      cancelWidget: Text("取消"),
                                    );
                                if (result != null) {
                                  //将数据保存起来
                                  controller.setArea(
                                    "${result.provinceName} ${result.cityName} ${result.areaName}",
                                  );
                                }
                              },
                              child: Obx(
                                () => Text(
                                  controller.ares.value == ""
                                      ? "所在地区"
                                      : controller.ares.value,
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(38),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text("详细地址:"),
                          SizedBox(width: 5),
                          Expanded(
                            child: TextField(
                              controller: controller.addressController,

                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: Screenadapter.fontSize(38),
                                ),
                                hintText: "请输入详细地址",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  //保存新增收货地址
                  controller.doAddress();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(
                      Screenadapter.width(50),
                    ),
                  ),
                  height: Screenadapter.height(140),
                  alignment: Alignment.center,
                  child: Text("保存"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
