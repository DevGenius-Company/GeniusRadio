import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig(
    this.host, {
    @required this.child,
  });

  final String host;
  final Widget child;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
