import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_step_login_controller.dart';

class OnStepLoginView extends GetView<OnStepLoginController> {
  const OnStepLoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('一键登录'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnStepLoginView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
