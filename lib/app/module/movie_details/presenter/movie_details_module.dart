import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MovieDetailsModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => SizedBox()),
  ];
}
