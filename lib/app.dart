import 'package:flutter/material.dart';

import 'presentation/views/qr_homepage.dart';
import 'theme/color_schemes.dart';

class QrScannerApp extends StatelessWidget {
  const QrScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme,fontFamily: 'Montserrat'),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme,fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      
      home: const QrHomePage(),
    );
  }
}


