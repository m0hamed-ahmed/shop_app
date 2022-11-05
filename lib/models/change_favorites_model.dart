class ChangeFavoritesModel {
  bool status;
  String message;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    message = map['message'];
  }
}