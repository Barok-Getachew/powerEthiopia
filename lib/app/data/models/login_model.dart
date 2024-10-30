class LoginReq {
  String? phoneNumber;
  String? password;

  LoginReq({this.phoneNumber, this.password});

  LoginReq.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}

class SignUpReq {
  String? fullName;
  String? phoneNumber;
  String? country;
  String? description;
  String? password;
  List<String?> imageUrl;
  String? status;

  SignUpReq({
    this.fullName,
    this.phoneNumber,
    this.country,
    this.description,
    this.password,
    required this.imageUrl,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['country'] = country;
    data['description'] = description;
    data['password'] = password;
    data['imageUrl'] = imageUrl;
    data['status'] = status;

    return data;
  }
}
