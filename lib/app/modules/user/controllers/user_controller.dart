import 'package:get/get.dart';
import '../../../models/user_model.dart';
import '../../../widgets/userServices.dart';

class UserController extends GetxController {
  RxBool isLogin = false.obs;
  // RxList userList = [].obs;
  var userInfo = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
   
    super.onClose();
  }

  getUserInfo() async {
    //获取登陆状态
    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;

    //获取用户数据
    var tempList = await UserServices.getUserInfo();
    if (tempList.isNotEmpty) {
      userInfo.value = UserModel.fromJson(tempList[0]);
       update();
    }
  }

  //推出登录
  loginOut() {
    UserServices.loginOut();
    isLogin.value = false;
    //把信息重置为空
    userInfo.value = UserModel();
    update();
  }
}
