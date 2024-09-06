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

class LocalData {
  final BuildContext context;
  LocalData({required this.context});

  Future<SharedPreferences> _prefS() async {
    prefs ??= await SharedPreferences.getInstance();
    getTiming();
    return prefs!;
  }

  spendingSet(Local data) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    try {
      if (mainProvider.amountData.isNotEmpty) {
        // print(mainProvider.amountData[0].date);
        // print(mainProvider.amountData[0].date.runtimeType);
        final json = mainDataToJson(mainProvider.amountData);
        // print(json);
        //! --- data process
        String? localIS = local(data);
        if (localIS != null) {
          _prefS().then((value) {
            value.setString(localIS, json);
          });
        }
        getTiming();
      } else {
        print('empty');
      }
    } catch (e) {
      e;
      print(e);
    }
  }

  getString(Local data) async {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    String? localIS = local(data);
    if (localIS != null) {
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
}

enum Local { spending, tags, source }

String? local(Local data) {
  print(data.toString());
  switch (data) {
    case Local.source:
      return 'source';
    case Local.spending:
      return 'spending';
    case Local.tags:
      return 'tags';
    default:
      return null;
  }
}
