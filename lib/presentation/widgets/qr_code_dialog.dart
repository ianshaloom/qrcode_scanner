import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeDialog extends StatelessWidget {
  final String scanResult;
  const QrCodeDialog({super.key, required this.scanResult});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 190),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
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
              data: scanResult,
              size: MediaQuery.of(context).size.width * 0.6,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Qr Code Contents',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                //
                isLink(scanResult)
                    ? IconButton(
                        onPressed: () => isLink(scanResult),
                        icon: Icon(
                          CupertinoIcons.globe,
                          size: 35,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            SizedBox(
              child: Text(
                scanResult,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Copy'),
                  ),
                ],
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
}
