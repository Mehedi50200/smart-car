class Car{
  String brand, imgUri, model,price;

  Car({
    this.brand,
    this.imgUri,
    this.model,
    this.price
  });

  Car.fromMap(Map<String, dynamic> map) {
    brand = map['brand'];
    imgUri = map['imgUri'];
    model = map['model'];
    price=map['price'];
    //releaseDate = DateTime.parse(map['release_date']);
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["brand"] = brand;
    map["imgUri"] = imgUri;
    map["model"] = model;
    map["price"] = price;
    return map;

  }
}