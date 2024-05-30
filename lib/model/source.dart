class Source {
  String amount;
  String name;
  String? color;

  Source({
    this.amount = '',
    this.name = '',
    this.color,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        amount: json["amount"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "name": name,
        "color": color,
      };
}
