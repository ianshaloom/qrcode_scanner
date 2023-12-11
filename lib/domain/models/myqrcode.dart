import 'package:hive_flutter/hive_flutter.dart';

part 'myqrcode.g.dart';

@HiveType(typeId: 0)
class MyQrCode extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String qrType;
  @HiveField(2)
  final String qrData;

  MyQrCode({
    required this.id,
    required this.qrType,
    required this.qrData,
  });
}
