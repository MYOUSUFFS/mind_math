// To parse this JSON data, do
//
//     final amountData = amountDataFromJson(jsonString);

import 'dart:convert';

import 'package:mind_math/model/source.dart';

AmountData amountDataFromJson(String str) =>
    AmountData.fromJson(json.decode(str));

String amountDataToJson(AmountData data) => json.encode(data.toJson());

class AmountData {
  DateTime? date;
  String? reason;
  String? amount;
  String? amountIs;
  Source? source;
  List<String?>? tags;

  AmountData({
    this.date,
    this.reason,
    this.amount,
    this.amountIs,
    this.source,
    this.tags,
  });

  factory AmountData.fromJson(Map<String, dynamic> json) => AmountData(
        date: json["date"],
        reason: json["reason"],
        amount: json["amount"],
        amountIs: json["amountIs"],
        source: Source.fromJson(json["source"]),
        tags: json["tags"] != null
            ? List<String?>.from(json["tags"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "reason": reason,
        "amount": amount,
        "amountIs": amountIs,
        "source": source?.toJson(),
        "tags": tags != null ? List<dynamic>.from(tags!.map((x) => x)) : null,
      };
}
