class Login {
  int? code;
  LoginData? data;

  Login({this.code, this.data});

  Login.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? LoginData?.fromJson(json['data']) : null;
  }
}

class LoginData {
  int? id;
  String? name;
  String? iqama;
  String? phone;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  LoginData(
      {this.id,
      this.name,
      this.iqama,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iqama = json['iqama'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  LoginData.fromLoginData(LoginData map) {
    id = map.id;
    name = map.name;
    iqama = map.iqama;
    phone = map.phone;
    email = map.email;
    emailVerifiedAt = map.emailVerifiedAt;
    createdAt = map.createdAt;
    updatedAt = map.updatedAt;
    token = map.token;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iqama'] = iqama;
    data['phone'] = phone;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
