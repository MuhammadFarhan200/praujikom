import 'package:flutter/material.dart';
import 'package:praujikom/views/home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget splashScreen = SplashScreenView(
      backgroundColor: const Color.fromARGB(255, 19, 0, 63),
      imageSize: 75,
      imageSrc: 'assets/images/splash.png',
      duration: 3000,
      textType: TextType.ScaleAnimatedText,
      pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
      navigateRoute: const HomePage(),
    );
    return MaterialApp(
      title: 'Doa Sehari-hari',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      home: splashScreen,
    );
  }
}
