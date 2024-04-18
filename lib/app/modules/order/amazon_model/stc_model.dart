class STCPayModel {
  String? data;
  String? msg;
  int? code;

  STCPayModel({this.data, this.msg, this.code});

  STCPayModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    msg = json['msg'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    data['msg'] = msg;
    data['code'] = code;
    return data;
  }
}