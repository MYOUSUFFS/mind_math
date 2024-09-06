import 'dart:convert';

import 'package:mind_math/model/source.dart';
import 'package:mind_math/model/tag.dart';

List<AmountData> mainDataFromJson(String str) =>
    List<AmountData>.from(json.decode(str).map((x) => AmountData.fromJson(x)));

String mainDataToJson(List<AmountData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

AmountData amountDataFromJson(String str) =>
    AmountData.fromJson(json.decode(str));

String amountDataToJson(AmountData data) => json.encode(data.toJson());

class AmountData {
  DateTime? date;
  String? reason;
  String? amount;
  String? amountIs;
  Source? source;
  List<Tags?>? tags;

  AmountData({
    this.date,
    this.reason,
    this.amount,
    this.amountIs,
    this.source,
    this.tags,
  });

  factory AmountData.fromJson(Map<String, dynamic> jsonIs) => AmountData(
        date: DateTime.tryParse(jsonIs["date"]),
        reason: jsonIs["reason"],
        amount: jsonIs["amount"],
        amountIs: jsonIs["amountIs"],
        source: Source.fromJson(jsonIs["source"]),
        tags: jsonIs["tags"] != null
            ? tagsFromJson(
                json.encode(jsonIs["tags"]),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "date": date.toString(),
        "reason": reason,
        "amount": amount,
        "amountIs": amountIs,
        "source": source?.toJson(),
        "tags": tags != null ? List<dynamic>.from(tags!.map((x) => x)) : null,
      };
}
