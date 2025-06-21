
import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../widgets/httpsclient.dart';


class CategoryController extends GetxController {
  //TODO: Implement CategoryController

  RxInt selectIndex = 0.obs;
  //左侧分类数据
  RxList<CategoryItemModel> leftcategoryList = <CategoryItemModel>[].obs;
  //右侧分类数据
  RxList<CategoryItemModel> rightcategoryList = <CategoryItemModel>[].obs;
  //添加数据未加载状态
  RxBool isLoading = true.obs;
  RxBool hasError = false.obs;
  String errorMessage = '';
  //加载网络请求
  HttpsClient httpsClient = HttpsClient();
  @override
  void onInit() {
    super.onInit();
    geLeftCategoryData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndex(index, id) {
    selectIndex.value = index;
    geRightCategoryData(id);
    update();
  }

  //获取左侧分类数据
  geLeftCategoryData() async {
    isLoading.value = true;
    hasError.value = false;
    try {
        var response = await httpsClient.get("api/pcate");
        if(response!=null){
    var category = CategoryModel.fromJson(response.data);
    leftcategoryList.value = category.result??[];//如果没有数据则返回空列表
        }
    if(leftcategoryList.isNotEmpty){
      geRightCategoryData(leftcategoryList[0].sId!);

    }else{
      hasError(true);
      errorMessage="没有数据";
    }
    } catch (e) {
      hasError(true);
      errorMessage = "加载失败";
    } finally {
      isLoading(false);
    }
    
  
    
  //  update();
  }

  //获取右侧分类数据
  geRightCategoryData(String pid) async {
    isLoading(true);
    hasError(false);
    try {
      var response = await httpsClient.get("api/pcate?pid=$pid");
      if(response!=null){

      
      var category = CategoryModel.fromJson(response.data);
      rightcategoryList.value = category.result ?? [];
      }
      if (rightcategoryList.isEmpty) {
        hasError(true);
        errorMessage = "没有子分类数据";
      }
    } catch (e) {
      hasError(true);
      errorMessage = "加载失败: $e";
    } finally {
      isLoading(false);
    }
  }
}
