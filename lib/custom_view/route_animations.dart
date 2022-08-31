import 'package:drkashikajain/custom_view/utils.dart';
import 'package:flutter/material.dart';

class BasePageRouteBuilder extends PageRouteBuilder {
  BasePageRouteBuilder({this.routeName});

  final String routeName;

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName))
      return super.settings;
    else
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
  }
}

class RouteAnimationNone extends PageRouteBuilder {
  RouteAnimationNone({@required this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return child;
        });

  final Widget widget;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}

class RouteAnimationNoneWithDuration extends PageRouteBuilder {
  RouteAnimationNoneWithDuration({@required this.widget, @required this.animDuration})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return child;
        });

  final Widget widget;
  final int animDuration;

  @override
  Duration get transitionDuration => Duration(milliseconds: animDuration);
}

class RouteAnimationSlideFromRight extends PageRouteBuilder {
  RouteAnimationSlideFromRight({this.widget, this.routeName})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });

  final Widget widget;
  final String routeName;

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName))
      return super.settings;
    else
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
  }
}

class RouteAnimationFadeIn extends PageRouteBuilder {
  RouteAnimationFadeIn(this.widget, this.shouldMaintainState, {this.routeName})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });

  final Widget widget;
  final String routeName;
  final bool shouldMaintainState;

  @override
  bool get maintainState {
    return shouldMaintainState;
  }

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName))
      return super.settings;
    else
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
  }
}

class RouteAnimationSlideFromBottom extends PageRouteBuilder {
  final Widget widget;
  final String routeName;

  RouteAnimationSlideFromBottom({this.widget, this.routeName})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        }, transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });

  @override
  RouteSettings get settings {
    if (Utils.isEmpty(routeName))
      return super.settings;
    else
      return RouteSettings(
        name: routeName,
        arguments: super.settings.arguments,
      );
  }
}
