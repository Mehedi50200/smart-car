class CarDetails{
  String brand, imgUri, model,year,color,mileage,engine,bodyStyle,price;

  CarDetails({
    this.brand,
    this.imgUri,
    this.model,
    this.year,
    this.color,
    this.mileage,
    this.engine,
    this.bodyStyle,
    this.price
  });

  CarDetails.fromMap(Map<String, dynamic> map) {
    brand = map['brand'];
    imgUri = map['imgUri'];
    price=map['price'];
    model = map['model'];
    year = map['year'];
    color = map['color'];
    mileage = map['mileage'];
    engine = map['engine'];
    bodyStyle = map['bodyStyle'];
    //releaseDate = DateTime.parse(map['release_date']);
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["brand"] = brand;
    map["imgUri"] = imgUri;
    map["model"] = model;
    map["year"] = year;
    map["color"] = color;
    map["mileage"] = mileage;
    map["engine"] = engine;
    map["bodyStyle"] = bodyStyle;
    map["price"] = price;
    return map;

  }
}