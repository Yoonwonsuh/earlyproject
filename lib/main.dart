import 'package:beamer/beamer.dart';
import 'package:earlyproject/router/locations.dart';
import 'package:earlyproject/screens/start_screen.dart';
import 'package:earlyproject/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:earlyproject/utils//logger.dart';

final _routerDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathPatterns: ['/'],
      check: (context, location) {
        return true;
      },
      showPage: BeamPage(child: StartScreen())),
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  logger.d('My first log by logger!!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(microseconds: 300), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(microseconds: 300),
              child: _splashloadingWidget(snapshot));
        });
  }

  StatelessWidget _splashloadingWidget(AsyncSnapshot<int> snapshot) {
    if (snapshot.hasError) {
      return Text('Error accur');
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        hintColor: Colors.grey[350],
        primarySwatch: Colors.red,
        fontFamily: 'DoHyeon',
        textTheme: TextTheme(
            headline3: TextStyle(fontFamily: 'DoHyeon'),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w700),
          elevation: 2,
        ),
      ),
      routeInformationParser: BeamerParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
