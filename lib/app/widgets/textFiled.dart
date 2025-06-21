import 'package:flutter/material.dart';
import '../widgets/screenAdapter.dart';

class PassTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  const PassTextField({
    super.key,
    this.onChanged,
    required this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.fromLTRB(
        Screenadapter.width(100),
        Screenadapter.width(50),
        Screenadapter.width(100),
        0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(Screenadapter.width(30)),
      ),
      child: TextField(
        keyboardType: keyboardType, //弹出键盘类型
        controller: controller,

        obscureText: isPassword,
        // autofocus: true,
        cursorColor: Colors.black, // 设置光标颜色为红色
        // cursorWidth: 1,//光标的宽度
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none, //去掉下划线
        ),
        onChanged: onChanged,
      ),
    );
  }
}
