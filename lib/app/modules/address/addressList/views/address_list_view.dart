import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/address_list_controller.dart';
import '../../../../widgets/screenAdapter.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('收货地址'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(Screenadapter.width(40)),
        child: Stack(
          children: [
            Obx(
              () =>
                  controller.addressList.isNotEmpty
                      ? ListView(
                        children:
                            controller.addressList.map((value) {
                              return value.defaultAddress == 1
                                  ? Column(
                                    children: [
                                      ListTile(
                                        leading: Icon(
                                          Icons.check_circle,
                                          color: Colors.red,
                                        ),
                                        title: InkWell(
                                          /*  onLongPress: () {
                                            Get.defaultDialog(
                                              barrierDismissible: false,
                                              title: "提示信息",
                                              middleText: "您确定要删除吗？",
                                              confirm: ElevatedButton(
                                                onPressed: () {
                                                   Get.back();
                                                },
                                                child: Text("确定"),
                                                
                                              ),
                                              cancel: ElevatedButton(
                                                onPressed: () {
                                                   Get.back();
                                                },
                                                child: Text("取消"),
                                              ),
                                            );
                                          }, */
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            controller.changeDefaultAddress(
                                              value.sId,
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${value.address}",
                                                style: TextStyle(
                                                  fontSize:
                                                      Screenadapter.fontSize(
                                                        38,
                                                      ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Screenadapter.height(
                                                  20,
                                                ),
                                              ),
                                              Text(
                                                "${value.name}  ${value.phone}",
                                                style: TextStyle(
                                                  fontSize:
                                                      Screenadapter.fontSize(
                                                        38,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Screenadapter.height(
                                                  20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            //修改地址
                                            Get.toNamed(
                                              "/address-edit",
                                              arguments: {
                                                "id": value.sId,
                                                "name": value.name,
                                                "phone": value.phone,
                                                "address": value.address,
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  )
                                  : Column(
                                    children: [
                                      ListTile(
                                        title: InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                          onLongPress: () {
                                            Get.defaultDialog(
                                              barrierDismissible: false,
                                              title: "提示信息",
                                              middleText: "您确定要删除吗？",
                                              confirm: ElevatedButton(
                                                onPressed: () {
                                                  controller.deleteAddress(
                                                    value.sId,
                                                  );
                                                  Get.back();
                                                },
                                                child: Text("确定"),
                                              ),
                                              cancel: ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("取消"),
                                              ),
                                            );
                                          },
                                        
                                          onTap: () {
                                            controller.changeDefaultAddress(
                                              value.sId,
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${value.address}",
                                                style: TextStyle(
                                                  fontSize:
                                                      Screenadapter.fontSize(
                                                        38,
                                                      ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: Screenadapter.height(
                                                  20,
                                                ),
                                              ),
                                              Text(
                                                "${value.name}  ${value.phone}",
                                                style: TextStyle(
                                                  fontSize:
                                                      Screenadapter.fontSize(
                                                        38,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: Screenadapter.height(
                                                  20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            //修改地址
                                            Get.toNamed(
                                              "/address-edit",
                                              arguments: {
                                                "id": value.sId,
                                                "name": value.name,
                                                "phone": value.phone,
                                                "address": value.address,
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  );
                            }).toList(),
                      )
                      : Text(""),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  // 跳转到收货地址编辑页面
                  Get.toNamed("/address-add");
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
                  child: Text("新建收货地址"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
