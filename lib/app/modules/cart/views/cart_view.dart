import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../views/cart_item_view.dart';
import '../../../widgets/Screenadapter.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView {
  //CartView在多个地方调用了，需要手动控制
  //不进行依赖注入，手动控制加载controller
  @override
  final CartController controller = Get.put(CartController());
  CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('购物车'),
        centerTitle: true,
        actions: [
          Obx(
            () =>
                controller.isEdit.value
                    ? TextButton(
                      onPressed: () {
                        //编辑删除cart列表
                        controller.changeEditState();
                      },
                      child: Text("完成"),
                    )
                    : TextButton(
                      onPressed: () {
                        controller.changeEditState();
                      },
                      child: Text("编辑"),
                    ),
          ),
        ],
      ),
      body:
      //不用Obs是因为不能及时刷新cart，和bootmShett一样
      GetBuilder<CartController>(
        //每次点击到购物车界面就会运行一次cartView，就可以实时刷新
        initState: (state) {
          print("GetBulider");
          controller.getCartListData();
        },
        init: controller,
        builder: (controller) {
          return controller.cartList.isNotEmpty
              ? Stack(
                children: [
                  ListView(
                    padding: EdgeInsets.only(bottom: Screenadapter.height(200)),
                    children:
                        controller.cartList.map((value) {
                          return CartItemView(value);
                        }).toList(),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: Colors.black,
                            width: Screenadapter.height(2),
                          ),
                        ),
                      ),
                      height: Screenadapter.height(200),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  activeColor: Colors.red,
                                  value: controller.checkedAllBox.value,
                                  onChanged: (value) {
                                    print(value);
                                    controller.checkedAllFun(value);
                                  },
                                ),
                              ),
                              const Text("全选"),
                            ],
                          ),
                          Obx(
                            () =>
                                controller.isEdit.value
                                    ? Row(
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                  const Color.fromRGBO(
                                                    255,
                                                    165,
                                                    0,
                                                    0.9,
                                                  ),
                                                ),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                  Colors.white,
                                                ),
                                            shape: WidgetStatePropertyAll(
                                              // CircleBorder()
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),

                                          onPressed: () {
                                            print("删除");
                                            controller.deleteCartData();
                                          },
                                          child: Text("删除"),
                                        ),
                                      ],
                                    )
                                    : Row(
                                      children: [
                                        Text("合计: "),
                                      Obx(()=>  Text(
                                          "¥${controller.allPrice.value}",
                                          style: TextStyle(
                                            fontSize: Screenadapter.fontSize(
                                              58,
                                            ),
                                            color: Colors.red,
                                          ),
                                        ),),
                                        SizedBox(
                                          width: Screenadapter.width(20),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                  const Color.fromRGBO(
                                                    255,
                                                    165,
                                                    0,
                                                    0.9,
                                                  ),
                                                ),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                  Colors.white,
                                                ),
                                            shape: WidgetStatePropertyAll(
                                              // CircleBorder()
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),

                                          onPressed: () {
                                            //判断用户用没有登录
                                            controller.checkout();
                                          },
                                          child: Text("结算"),
                                        ),
                                      ],
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : Container(alignment: Alignment.center, child: Text("购物车空空的！"));
        },
      ),
    );
  }
}
