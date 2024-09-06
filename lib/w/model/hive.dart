import 'package:hive/hive.dart';

import '../../model/amount_data.dart';

part 'hive.g.dart';

@HiveType(typeId: 0)
class SpendingData {
  SpendingData(this.spending);
  @HiveField(0)
  List<AmountData> spending;
}
