import 'package:edistribution/menu.dart';
import 'package:edistribution/notFound.dart';
import 'package:edistribution/router/routeConstant.dart';
import 'package:edistribution/trustfall/trusftfall.dart';
import 'package:flutter/material.dart';

class  Routers {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case menuRoute:
        return MaterialPageRoute(builder: (_) => Menu());
      case trustFallRoute:
        return MaterialPageRoute(builder: (_) => Trustfall());
      default:
        return MaterialPageRoute(builder: (_) => NotFound());
    }
  }
}
