class CarParts{
  String title, imgUri, price;

  CarParts({
    this.title,
    this.imgUri,
    this.price,
  });

  CarParts.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    imgUri = map['imgUri'];
    price = map['price'];
    //releaseDate = DateTime.parse(map['release_date']);
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["imgUri"] = imgUri;
    map["price"] = price;
    return map;

  }
}