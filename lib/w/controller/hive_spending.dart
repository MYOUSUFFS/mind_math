// ignore_for_file: avoid_print

import 'package:hive/hive.dart';

class HiveInit {
  Box<dynamic>? b;
  Future<Box<dynamic>?> _init() async {
    if (b == null) {
      final bool checkBox = Hive.isBoxOpen('spendings');
      if (checkBox) {
        b = Hive.box('spendings');
        print(b!.name);
        print(b!.path);
        print(b!.keys);
        print(b!.length);
        return b;
      } else {
        b = await Hive.openBox('spendings');
        print(b!.name);
        print(b!.path);
        return b;
      }
      // b = Hive.box('spendings');
      // print('object');
      // print(b!.isOpen);
      // if (b!.isOpen) {
      //   print(b?.name);
      //   print(b?.path);
      //   return b;
      // } else {
      //   await Hive.openBox('spendings');
      //   b = Hive.box('spendings');
      //   print(b?.name);
      //   print(b?.path);
      //   return b;
      // }
    } else {
      return null;
    }
  }

  Future<Box<dynamic>?> boxIs() async {
    final n = await _init();
    return n;
  }

  getHive() {
    var h = Hive.box('spendings');
    if (h.isOpen)
      print(h.name);
    else
      print('Box Closed');
  }

  static removeHive() {
    Hive.deleteFromDisk();
  }
}
