import 'package:flutter/material.dart';
import '../widgets/screenAdapter.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(Screenadapter.width(80)),
      child: SizedBox(
        width: Screenadapter.width(180),
        height: Screenadapter.height(180),
        child: Image.asset("assets/images/logo.png", fit: BoxFit.cover),
      ),
    );
  }
}
