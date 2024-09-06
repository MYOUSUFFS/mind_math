import 'package:flutter/cupertino.dart';
import 'package:mind_math/model/source.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../model/amount_data.dart';
import '../model/tag.dart';

// Todo - This is a future and many time we need this so i put here.
SharedPreferences? prefs;

class MainProvider with ChangeNotifier {
  // Todo - This main data sets
  final List<AmountData> _amountData = [];
  List<AmountData> get amountData => _amountData;

  setDataSp(List<AmountData> data) {
    _amountData.clear();
    _amountData.addAll(data);
    notifyListeners();
  }

  void addAmountData(AmountData amountData) {
    source.any((element) {
      if (element.name == amountData.source?.name) {
        if (amountData.amountIs == 'DR') {
          element.amount =
              '${double.parse(element.amount) - double.parse(amountData.amount ?? '0')}';
        } else {
          element.amount =
              '${double.parse(element.amount) + double.parse(amountData.amount ?? '0')}';
        }
        return true;
      } else {
        return false;
      }
    });
    amountData.source!.name;
    _amountData.add(amountData);
    notifyListeners();
  }

  void removeAmountData(AmountData amountData) {
    _amountData.remove(amountData);
    notifyListeners();
  }

  // Todo - Tags list of tags
  final List<Tags> _tag = [];
  List<Tags> get tag => _tag;

  void addTag(Tags data) {
    if (_tag.contains(data)) return;
    _tag.add(data);
    notifyListeners();
  }

  void removeTag(Tags tag) {
    _tag.remove(tag);
    notifyListeners();
  }

  // Todo - List of source
  final List<Source> _source = [];
  List<Source> get source => _source;

  void addSource(Source data) {
    if (data.amount.isEmpty || data.name.isEmpty) {
      toast('Return Empty');
      return;
    } else if (_source.any((element) => element.name == data.name)) {
      toast('Source Already Exists');
      return;
    }
    _source.add(data);
    notifyListeners();
  }

  void removeSource(Source data) {
    _source.remove(data);
    notifyListeners();
  }

  //! ------------- Local Storage ------------
  var _pref;
  get pref => _pref;
}
