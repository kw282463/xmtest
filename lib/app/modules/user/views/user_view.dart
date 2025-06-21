import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../widgets/passButton.dart';
import '../../../widgets/myFonts.dart';
import '../../../widgets/screenAdapter.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent, // 添加这一行,让appbar背井不会会被覆盖
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Screenadapter.width(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("会员码"),
                SizedBox(
                  height: Screenadapter.height(100),
                  width: Screenadapter.width(100),
                  child: IconButton(
                    padding: EdgeInsets.zero,

                    onPressed: () {},
                    icon: Icon(Icons.qr_code),
                  ),
                ),
                SizedBox(
                  height: Screenadapter.height(100),
                  width: Screenadapter.width(100),
                  child: IconButton(
                    padding: EdgeInsets.zero,

                    onPressed: () {},
                    icon: Icon(Icons.settings_outlined),
                  ),
                ),
                SizedBox(
                  height: Screenadapter.height(100),
                  width: Screenadapter.width(100),
                  child: IconButton(
                    padding: EdgeInsets.zero,

                    onPressed: () {},
                    icon: Icon(Icons.message_outlined),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(Screenadapter.height(40)),
        children: [
          SizedBox(
            child: //头像
                Obx(() {
              return controller.isLogin.value
                  ? Row(
                    children: [
                      SizedBox(width: Screenadapter.width(40)),
                      SizedBox(
                        height: Screenadapter.height(150),
                        width: Screenadapter.width(150),
                        child: CircleAvatar(
                          radius: Screenadapter.width(50),
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                      ),
                      SizedBox(width: Screenadapter.width(40)),
                      Text(
                        "${controller.userInfo.value.username}",
                        style: TextStyle(fontSize: Screenadapter.fontSize(46)),
                      ),

                      SizedBox(width: Screenadapter.width(20)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: Screenadapter.fontSize(34),
                        color: Colors.black54,
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      SizedBox(width: Screenadapter.width(40)),
                      SizedBox(
                        height: Screenadapter.height(150),
                        width: Screenadapter.width(150),
                        child: CircleAvatar(
                          radius: Screenadapter.width(50),
                          backgroundImage: AssetImage("assets/images/user.png"),
                        ),
                      ),
                      SizedBox(width: Screenadapter.width(40)),
                      InkWell(
                        //不要颜色，只要点击点击动画
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed("/code-login-step-one");
                        },
                        child: Text(
                          "登录/注册",
                          style: TextStyle(
                            fontSize: Screenadapter.fontSize(46),
                          ),
                        ),
                      ),
                      SizedBox(width: Screenadapter.width(20)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: Screenadapter.fontSize(34),
                        color: Colors.black54,
                      ),
                    ],
                  );
            }),
          ),
          //钱包优惠卷米金
          Obx(
            () =>
                controller.userInfo.value.gold != null
                    ? Container(
                      margin: EdgeInsets.only(top: Screenadapter.height(20)),

                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "${controller.userInfo.value.gold}",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "米金",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "${controller.userInfo.value.coupon}",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "优惠劵",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "${controller.userInfo.value.redPacket}",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "红包",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "${controller.userInfo.value.quota}",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "最高额度",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    MyFonts.qianbao,
                                    size: Screenadapter.fontSize(80),
                                  ),
                                ),
                                Text(
                                  "钱包",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    : Container(
                      margin: EdgeInsets.only(top: Screenadapter.height(20)),

                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "米金",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "优惠劵",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "红包",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                  ),
                                ),
                                Text(
                                  "最高额度",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    MyFonts.qianbao,
                                    size: Screenadapter.fontSize(80),
                                  ),
                                ),
                                Text(
                                  "钱包",
                                  style: TextStyle(
                                    fontSize: Screenadapter.fontSize(34),
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
          ), //广告图片
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),

            child: Container(
              width: double.infinity,
              height: Screenadapter.height(300),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/user_ad1.png"),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(Screenadapter.width(20)),
              ),
            ),
          ),
          //收藏 待付款等
          Container(
            margin: EdgeInsets.only(top: Screenadapter.height(40)),
            padding: EdgeInsets.all(Screenadapter.width(40)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Screenadapter.width(20)),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.1),
                    ),
                  ),
                  child: //收藏足迹
                      Obx(
                    () => Container(
                      margin: EdgeInsets.only(bottom: Screenadapter.height(20)),
                      height: Screenadapter.height(100),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "收藏 ",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${controller.userInfo.value.collect}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: Screenadapter.width(2),
                                    color: Colors.black12,
                                  ),
                                  right: BorderSide(
                                    width: Screenadapter.width(2),
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "足迹 ",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${controller.userInfo.value.footmark}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "关注 ",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    "${controller.userInfo.value.follow}",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Screenadapter.height(30)),
                //待付款，全部订单等图标
                Container(
                  margin: EdgeInsets.fromLTRB(
                    Screenadapter.width(10),
                    Screenadapter.height(50),
                    Screenadapter.height(10),
                    Screenadapter.height(50),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(MyFonts.daifukuan),
                            Text(
                              "待付款",
                              style: TextStyle(
                                fontSize: Screenadapter.fontSize(34),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(MyFonts.daishouhuo),
                            Text(
                              "待收货",
                              style: TextStyle(
                                fontSize: Screenadapter.fontSize(34),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(MyFonts.daipingjia),
                            Text(
                              "待评价",
                              style: TextStyle(
                                fontSize: Screenadapter.fontSize(34),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(MyFonts.tuihuan),
                            Text(
                              "售后",
                              style: TextStyle(
                                fontSize: Screenadapter.fontSize(34),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed("/order");
                          },
                          child: Column(
                            children: [
                              Icon(
                                MyFonts.quanbudingdan,
                                size: Screenadapter.height(80),
                              ),
                              Text(
                                "订单",
                                style: TextStyle(
                                  fontSize: Screenadapter.fontSize(34),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Icon(MyFonts.daifukuan),
                            Text(
                              "待付款",
                              style: TextStyle(
                                fontSize: Screenadapter.fontSize(34),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //服务等内容
          Container(
            margin: EdgeInsets.only(top: Screenadapter.height(40)),
            padding: EdgeInsets.all(Screenadapter.width(40)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Screenadapter.width(20)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "服务",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: Screenadapter.fontSize(44),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("更多 > ", style: TextStyle(color: Colors.black54)),
                  ],
                ),
                SizedBox(height: Screenadapter.height(20)),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(), //进制滚动
                  crossAxisCount: 4,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: Screenadapter.height(40), //垂直方向列之间的距离

                  shrinkWrap: true, //收缩
                  children: [
                    Column(
                      children: [
                        Icon(MyFonts.genghuan, color: Colors.blue),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("一键安装"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.genghuan, color: Colors.orange),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("一键退换"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.genghuan, color: Colors.purple),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("一键维修"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.fuwu, color: Colors.orange),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("服务进度"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.xiaomi1, color: Colors.orange),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("小米之家"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.kefu, color: Colors.blue),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("客服"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.genghuan, color: Colors.green),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("更换"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(MyFonts.dianchi, color: Colors.green),
                        SizedBox(height: Screenadapter.height(20)),
                        Text("手机电池"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //广告2
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),

            child: Container(
              width: double.infinity,
              height: Screenadapter.height(300),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/user_ad2.png"),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(Screenadapter.width(20)),
              ),
            ),
          ),
          PassButton(
            text: "退出登录",
            onPressed:
                () => //退出登录
                    controller.loginOut(),
          ),
        ],
      ),
    );
  }
}
