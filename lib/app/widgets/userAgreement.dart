import 'package:flutter/material.dart';

import '../widgets/screenAdapter.dart';
class UserAgreement extends StatelessWidget {
  const UserAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.only(left: Screenadapter.width(40)),
            margin: EdgeInsets.all( Screenadapter.height(20)),
            child: Wrap(
              crossAxisAlignment:WrapCrossAlignment.center,
              children: [
                Checkbox(
                    activeColor: Colors.red, value: true, onChanged: (v) {}),
                 Text(
                  "已阅读并同意",style: TextStyle(fontSize: Screenadapter.fontSize(38)),),
                 Text(
                  "《商城用户协议》",
                  style: TextStyle(color: Colors.red,fontSize: Screenadapter.fontSize(38)),
                ),
                   Text(
                  "《商城用户协议》",
                  style: TextStyle(color: Colors.red,fontSize: Screenadapter.fontSize(38)),
                ),
                 Text("《商城隐私协议》", style: TextStyle(color: Colors.red,fontSize: Screenadapter.fontSize(38))),
              ],
            ),
          );
  }
}