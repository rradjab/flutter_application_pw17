class ProductModel {
  String? id;
  String? userEmail;
  String? name;
  num? price;
  bool? purchased;
  ProductModel(
      {this.id, this.name, this.price, this.purchased, this.userEmail});

  ProductModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json['name'];
    purchased = json['purchased'];
    price = json['price'];
    userEmail = json['userEmail'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['purchased'] = purchased;
    data['price'] = price;
    data['userEmail'] = userEmail;
    return data;
  }
}
