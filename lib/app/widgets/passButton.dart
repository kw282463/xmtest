import 'package:flutter/material.dart';
import '../widgets/screenAdapter.dart';

class PassButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const PassButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Screenadapter.width(80)),
      margin: EdgeInsets.only(top:Screenadapter.height(60)),
      height: Screenadapter.height(140),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.orange),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          //设置按钮圆角，默认比较大
          /* shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Screenadapter.height(20)),
                  ),
                ), */
        ),
        child: Text(text),
      ),
    );
  }
}
