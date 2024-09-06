// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:myself/myself.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../model/amount_data.dart';
import 'main_provider.dart';

void getTiming() {
  final stopwatch = Stopwatch()..start();
  stopwatch.stop();
  final isT = MySelfColor()
      .printError(text: 'Function Execution Time : ${stopwatch.elapsed}');
  return isT;
}

class SpendingLocalData {
  Future<SharedPreferences> _prefS() async {
    prefs ??= await SharedPreferences.getInstance();
    getTiming();
    return prefs!;
  }

  spendingSet(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      if (mainProvider.amountData.isNotEmpty) {
        // print(mainProvider.amountData[0].date);
        // print(mainProvider.amountData[0].date.runtimeType);
        final json = mainDataToJson(mainProvider.amountData);
        // print(json);
        //! --- data process
        _prefS().then((value) {
          value.setString('spending', json);
        });
        getTiming();
      } else {
        print('empty');
      }
    } catch (e) {
      e;
      print(e);
    }
    // _prefS().then((value) {
    //   if (mainProvider.amountData.isNotEmpty) {
    //     value.setString('spending', json);
    //   }
    // });
    // getTiming();
  }

  getString(BuildContext context) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    final String spending = await _prefS().then((value) {
      return value.getString('spending') ?? '';
    });
    print(spending);
    print(spending.runtimeType);
    if (spending.isNotEmpty) {
      mainProvider.setDataSp(mainDataFromJson(spending));
    } else {
      print('No Data');
    }
  }
}
