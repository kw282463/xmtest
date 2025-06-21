class HotModel {
  List<HotItemModel>? result;

  HotModel({this.result});

  HotModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <HotItemModel>[];
      json['result'].forEach((v) {
        result!.add( HotItemModel.fromJson(v));
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

class HotItemModel {
  String? sId;
  String? title;
  String? status;
  String? pic;
  String? url;
  int? position;

  HotItemModel(
      {this.sId, this.title, this.status, this.pic, this.url, this.position});

  HotItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    data['position'] = this.position;
    return data;
  }
}
