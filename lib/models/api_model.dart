class ApiModel {
  ApiModel({
    this.id,
    this.name,
    this.description,
    this.price,
  });

  String? id;
  String? name;
  String? description;
  double? price;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
      );
}
