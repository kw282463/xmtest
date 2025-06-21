import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/httpsclient.dart';
import '../../../../widgets/userServices.dart';
import '../../../../widgets/signServices.dart';
import '../../../../models/user_model.dart';
import '../../../address/addressList/controllers/address_list_controller.dart';

class AddressEditController extends GetxController {
  //TODO: Implement AddressEditController
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString ares = "".obs;
  HttpsClient httpsClient = HttpsClient();
  AddressListController listController=Get.find<AddressListController>();
  @override
  void onInit() {
    initAddressData();
    super.onInit();
  }

  //设置用户选择的地址
  setArea(String str) {
    ares.value = str;
    update();
  }

  initAddressData() {
    nameController.text = Get.arguments["name"];
    phoneController.text = Get.arguments["phone"];
    // addressController.text=Get.arguments["address"];
    // 把数据的城市i信息放在所在地区，拆分数据实现
    String address = Get.arguments["address"];
    print("----------------$address");
    //地址时空格分开的，保存数据的时候要记得加入空格。不然会报错
    List addressList = address.split(" ");
    print("----------------$addressList");
    ares.value = "${addressList[0]} ${addressList[1]} ${addressList[2]}";
    addressList.removeRange(0, 3);
    print("----------------$addressList");
    addressController.text = addressList.join(" ");
  }

  //保存用户的地址
  doEditAddress() async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    if (nameController.text.length < 2) {
      Get.snackbar("提示信息", "请把姓名填写完整");
    } else if (!GetUtils.isPhoneNumber(phoneController.text) ||
        phoneController.text.length != 11) {
      Get.snackbar("提示信息", "手机号不合法");
    } else if (ares.value.length < 2) {
      Get.snackbar("提示信息", "请选择地区");
    } else if (addressController.text.length < 2) {
      Get.snackbar("提示信息", "请填写详细地址");
    } else {
      //进行签名
      Map temoJson = {
        "uid": userInfo.sId,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": "${ares.value} ${addressController.text}",
      };

      String sign = Signservices.getSign({
        ...temoJson, //合并对象，会和下面的salt合并成为一个json数据
        "salt": userInfo.salt, //登录成功服务器会返回
      });
      var response = await httpsClient.post(
        "api/addAddress",
        data: {...temoJson, "sign": sign},
      );
      print("===========$response");
      if (response.data["success"]) {
        //  Get.snackbar("增加收货地址成功", response.data["message"]);
        Get.back();
      } else {
        Get.snackbar("提示信息", response.data["message"]);
      }
    }
  }

  @override
  void onClose() {
    //返回时更新列表数据
    listController.getAddressList();
    super.onClose();
  }
}
