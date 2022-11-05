class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    data = HomeDataModel.fromJson(map['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> map) {
    map['banners'].forEach((element) {banners.add(BannerModel.fromJson(element));});
    map['products'].forEach((element) {products.add(ProductModel.fromJson(element));});
  }
}

class BannerModel {
  int id;
  String image;

  BannerModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    image = map['image'];
  }
}

class ProductModel {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  bool inFavorites;
  bool inCart;

  ProductModel.fromJson(Map<String, dynamic> map) {
    id= map['id'];
    price= map['price'];
    oldPrice= map['old_price'];
    discount= map['discount'];
    image= map['image'];
    name= map['name'];
    inFavorites= map['in_favorites'];
    inCart= map['in_cart'];
  }
}