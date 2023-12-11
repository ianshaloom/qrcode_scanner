import 'package:hive_flutter/hive_flutter.dart';

import '../constants.dart';
import '../domain/models/myqrcode.dart';

class HiveBoxes{
  static Box<MyQrCode> get mpesaQrCodesBox => Hive.box<MyQrCode>(qrCodesBox);
}