import './storage.dart';

class UserServices {
  static Future<List> getUserInfo() async {
    List? userinfo = await Storage.getData("userinfo");
    if (userinfo != null) {
      return userinfo;
    } else {
      return [];
    }
  }

  static Future<bool> getUserLoginState() async {
    List userinfo = await getUserInfo();
    if (userinfo.isNotEmpty && userinfo[0]["username"] != "") {
      return true;
    } else {
      return false;
    }
  }

  //推出登录
  static loginOut() async {
    Storage.removeData("userinfo");
  }
}
