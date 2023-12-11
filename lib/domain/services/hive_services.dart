import '../../hive/hive_boxes.dart';
import '../models/myqrcode.dart';

class HiveQrServices {
  HiveQrServices._();
  static final HiveQrServices _instance = HiveQrServices._();
  factory HiveQrServices() => _instance;

  final box = HiveBoxes.mpesaQrCodesBox;

  // add to hive
  Future saveQrCodeToHive(MyQrCode myQrCode) async {
    await box.add(myQrCode);
  }

  // get all from hive
  Future<List<MyQrCode>> allQrCodesFromHive() async {
    final List<MyQrCode> qrCodes = box.values.toList();

    return qrCodes;
  }
}
