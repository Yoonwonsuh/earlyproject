import 'package:beamer/beamer.dart';
import 'package:earlyproject/screens/start_screen.dart';
import 'package:earlyproject/screens/home_screen.dart';
import 'package:flutter/widgets.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    return [
      BeamPage(child: StartScreen(), key: ValueKey('home')),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/','/login'];
}
