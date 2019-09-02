import 'package:flutter/material.dart';
import 'package:onboarding/providers/color_proivder.dart';
import 'package:onboarding/screens/onboarding/onboarding.dart';
import 'package:onboarding/themes/styles.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnBoarding App',
      theme: appTheme(),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        builder: (context) => ColorProvider(),
        child: Onboarding(),
      ),
    );
  }
}
