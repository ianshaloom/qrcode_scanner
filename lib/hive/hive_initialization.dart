import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import '../domain/models/myqrcode.dart';

class HiveInitialization {
  static Future<void> initFlutter(String subDir) async {
    Hive.init(subDir);
    await Hive.openBox<MyQrCode>(qrCodesBox);
  }

  static Future<void> registerAdapters() async {
    Hive.registerAdapter(MyQrCodeAdapter());
  }
}
