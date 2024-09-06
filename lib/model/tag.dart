class Tags {
  String name;
  String? color;

  Tags({
    this.name = '',
    this.color,
  });

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "color": color,
      };
}
