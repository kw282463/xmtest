import 'package:get/get.dart';
import '../../../widgets/storage.dart';
import '../../../widgets/userServices.dart';
import '../../../widgets/cartServices.dart';

class CartController extends GetxController {
  RxList cartList = [].obs;
  RxBool checkedAllBox = false.obs;
  //是否可以删除数据
  RxBool isEdit = false.obs;
  RxDouble allPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    //   CartServices.clearCartData();
    //只会触发一次，不能实时更新
    //放在CartView的GetBulider去就可以
    //  getCartListData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //获取cartlist的数据
  void getCartListData() async {
    var tempList = await CartServices.getCartList();
    cartList.value = tempList;
    checkedAllBox.value = isCheckedAll();
    //计算总价
      computedAllPrice() ;
    update();
  }

  //增加数量
  void upCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        cartList[i]["count"]++;
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
      //计算总价
      computedAllPrice() ;
    update();
  }

  //减少数量
  void dnCartNum(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        if (cartList[i]["count"] > 1) {
          cartList[i]["count"]--;
        }
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
      //计算总价
      computedAllPrice() ;
    update();
  }

  //选择对应item
  void checkCartItem(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        cartList[i]["checked"] = !cartList[i]["checked"];
      }
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    checkedAllBox.value = isCheckedAll();
      //计算总价
      computedAllPrice() ;
    update();
  }

  //全选 反选
  void checkedAllFun(value) {
    checkedAllBox.value = value;
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      cartList[i]["checked"] = value;
      tempList.add(cartList[i]);
    }
    cartList.value = tempList;
    CartServices.setCartList(tempList);
      //计算总价
      computedAllPrice() ;
    update();
  }

  //判断是否全选
  bool isCheckedAll() {
    if (cartList.isNotEmpty) {
      for (var i = 0; i < cartList.length; i++) {
        if (cartList[i]["checked"] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  //获取要结算的商品
  getCheckListData() {
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempList.add(cartList[i]);
      }
    }
    return tempList;
  }

  //获取用户是否登录状态
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  //检查用户是否登录
  checkout() async {
    bool loginState = await isLogin();
    List checkListData = getCheckListData();
    if (loginState) {
      //判断购物车中是否有结算的商品
      if (checkListData.isNotEmpty) {
        //保存购物车选择的商品到本地存储
        Storage.setData("checkListData", checkListData);
        Get.toNamed("/checkout");
      } else {
        Get.snackbar("提示信息", "购物车没有要结算的商品");
      }
    } else {
      //执行跳转
      Get.toNamed("/code-login-step-one");
      Get.snackbar("提示信息", "你还没有登录，请先登录");
    }
  }

  //改变isEdit可以编辑购物车列表
  changeEditState() {
    isEdit.value = !isEdit.value;
    update();
  }

  //删除购物车数据
  deleteCartData() {
    List tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == false) {
        tempList.add(cartList[i]);
      }
    }
    //把没有选中的商品保存在cart里面
    cartList.value = tempList;
    CartServices.setCartList(tempList);
    update();
  }

  //计算总价
  computedAllPrice() {
    double tempAllPrice = 0.0;
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"] == true) {
        tempAllPrice += cartList[i]["price"] * cartList[i]["count"];
      }
    }
    allPrice.value = tempAllPrice;
  }
}
