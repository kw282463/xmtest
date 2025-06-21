import 'package:get/get.dart';
import '../../../../models/address_model.dart';
import '../../../../widgets/signServices.dart';

import '../../../../models/user_model.dart';
import '../../../../widgets/httpsclient.dart';
import '../../../../widgets/userServices.dart';
import '../../../checkout/controllers/checkout_controller.dart';

class AddressListController extends GetxController {
  //TODO: Implement AddressListController
  HttpsClient httpsClient = HttpsClient();
  RxList<AddressItemModel> addressList = <AddressItemModel>[].obs;
  CheckoutController checkoutController=Get.find<CheckoutController>();


  @override
  void onInit() {
    getAddressList();
    super.onInit();
  }

  @override
  void onClose() {
    checkoutController.getDefaultAddress();
    super.onClose();
  }

  //获取用户的地址信息

  getAddressList() async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sId};
    String sign = Signservices.getSign({
      ...tempJson,
      //私钥
      "salt": userInfo.salt,
    });

    var response = await httpsClient.get(
      "api/addressList?uid=${userInfo.sId}&sign=$sign",
    );
    print("api/addressList?uid=${userInfo.sId}&sign=$sign");
    print("=======$response");
    if (response != null) {
      var tempAddressList = AddressModel.fromJson(response.data);
      addressList.value = tempAddressList.result!;
      update();
    }
  }

  //改变用户的默认地址
  changeDefaultAddress(id) async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    //签名
    Map tempJson = {"uid": userInfo.sId, "id": id};
    String sign = Signservices.getSign({
      ...tempJson,
      //私钥
      "salt": userInfo.salt,
    });

    var response = await httpsClient.post(
      "api/changeDefaultAddress",
      data: {
        ...tempJson,
        "sign":sign
      }
    );
    print("=======$response");
    if (response != null) {
      Get.back();
    }
  }
//删除收货地址
deleteAddress(id)async {
    //获取用户信息
    List userList = await UserServices.getUserInfo();
    print(userList);
    UserModel userInfo = UserModel.fromJson(userList[0]);
    //签名
    Map tempJson = {"uid": userInfo.sId, "id": id};
    String sign = Signservices.getSign({
      ...tempJson,
      //私钥
      "salt": userInfo.salt,
    });

    var response = await httpsClient.post(
      "api/deleteAddress",
      data: {
        ...tempJson,
        "sign":sign
      }
    );
    print("=======$response");
    if (response != null) {
      //删除成功重新更新页面数据
      getAddressList();
    }
  }

}
