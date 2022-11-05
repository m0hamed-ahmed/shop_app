class ShopLoginModel {
  bool status;
  String message;
  UserData data;

  ShopLoginModel.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    message = map['message'];
    data = map['data'] != null ? UserData.fromJson(map['data']) : null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
    points = map['points'];
    credit = map['credit'];
    token = map['token'];
  }
}