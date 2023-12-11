import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/domain/models/myqrcode.dart';
// import 'package:url_launcher/url_launcher.dart';

class QrCodeCard extends StatelessWidget {
  final MyQrCode qrCode;
  const QrCodeCard({super.key, required this.qrCode});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                QrImageView(
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  backgroundColor: Colors.white,
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle,
                    color: Colors.black,
                  ),
                  data: qrCode.qrData,
                  size: MediaQuery.of(context).size.width * 0.5,
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await qrCode.delete();
                      },
                      icon: Icon(
                        CupertinoIcons.delete,
                        size: 35,
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    // open browser
                    isLink(qrCode.qrData)
                        ? IconButton(
                            onPressed: () => openBrowser(qrCode.qrData),
                            icon: Icon(
                              CupertinoIcons.globe,
                              size: 35,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Qr Code Contents',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            SizedBox(
              child: Text(
                qrCode.qrData,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isLink(String text) {
    Uri? uri = Uri.tryParse(text);
    return uri != null && uri.isAbsolute;
  }

  Future<void> openBrowser(String url) async {
    // final Uri u = Uri.parse(url);

    // // check if can launch
    // if (!await canLaunchUrl(u)) {
    //   throw Exception('Could not launch $u');
    // }

    // // open url
    // await launchUrl(u);
  }
}
