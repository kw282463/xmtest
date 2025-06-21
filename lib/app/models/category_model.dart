class CategoryModel {
  List<CategoryItemModel>? result;

  CategoryModel({this.result});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result =<CategoryItemModel>[];
      json['result'].forEach((v) {
        result!.add( CategoryItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItemModel {
  String? sId;
  String? title;
  int? status;
  String? pic;
  String? pid;
  int? sort;
  int? isBest;
  int? goProduct;
  String? productId;

  CategoryItemModel(
      {this.sId,
      this.title,
      this.status,
      this.pic,
      this.pid,
      this.sort,
      this.isBest,
      this.goProduct,
      this.productId});

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
    isBest = json['is_best'];
    goProduct = json['go_product'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data['sort'] = this.sort;
    data['is_best'] = this.isBest;
    data['go_product'] = this.goProduct;
    data['product_id'] = this.productId;
    return data;
  }
}
