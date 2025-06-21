import 'dart:convert';

import 'package:crypto/crypto.dart';

/* class Signservices {
  static getSign() {
    //1.获取登陆成功后返回的数据里面的salt(私钥)
    //2.获取请求的所有参数
    //3.生成一个map类型对象
    //4.获取map对象的key 按照ASCII字符顺序进行升序排序（也就是自然排序）
    //5.拼接字符串
    //6.md5加密字符串
    Map demoJson = {
      "aid": 1,
      "name": "zhangsan",
      "age": 20,
      "sex": "男",
      "salt": "hdhashshhcx", //私钥
    };

    List jsonKeys = demoJson.keys.toList();
    print(jsonKeys); //[aid,name,age,sex,salt]
    jsonKeys.sort(); //排序print[age,aid,name,salt,sex]

    String str = "";
    for (var i = 0; i < jsonKeys.length; i++) {
      str += "${jsonKeys[i]}${demoJson[jsonKeys[i]]}";
    }

    print(str); //age20aid1namezhangsansex男salthdhashshhcx

    //加密数据
    var sign = md5.convert(utf8.encode(str));
    print(sign);
  }
} */

class Signservices {
  static getSign(Map json) {
    List jsonKeys = json.keys.toList();
    jsonKeys.sort();

    String str = "";
    for (var i = 0; i < jsonKeys.length; i++) {
      str += "${jsonKeys[i]}${json[jsonKeys[i]]}";
    }

    //加密数据
    var sign = md5.convert(utf8.encode(str));
    return "$sign";
  }
}
