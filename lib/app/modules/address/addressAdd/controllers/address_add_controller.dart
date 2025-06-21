import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../modules/address/addressList/controllers/address_list_controller.dart';
import '../../../../widgets/httpsclient.dart';
import '../../../../widgets/signServices.dart';
import '../../../../models/user_model.dart';
import '../../../../widgets/userServices.dart';

class AddressAddController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString ares = "".obs;
  HttpsClient httpsClient = HttpsClient();
  //实例化AddressList，在销毁页面时加载获取列表数据
  AddressListController listController = Get.find<AddressListController>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    //当新增地址完成返回到收货地址界面时，即使更新新增的地址数据
    listController.getAddressList();
    super.onClose();
  }

  //设置用户选择的地址
  setArea(String str) {
    ares.value = str;
    update();
  }

  //保存用户的地址
  doAddress() async {
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
}
