import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeInWithSlideUpAnimation extends StatelessWidget {
  const FadeInWithSlideUpAnimation({this.delay = 1, this.child, this.animationHeight = 40});

  final double delay;
  final double animationHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity').add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track('translateY').add(const Duration(milliseconds: 400), Tween(begin: 40.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay.round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(offset: Offset(0, animation['translateY']), child: child),
      ),
    );
  }
}

class FadeOutWithSlideUpAnimation extends StatelessWidget {
  const FadeOutWithSlideUpAnimation({this.delay = 1, this.child});

  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('opacity')
          .add(Duration(milliseconds: delay.toInt()), Tween(begin: 1.0, end: 1.0))
          .add(const Duration(milliseconds: 400), Tween(begin: 1.0, end: 0.0)),
      Track('translateY')
          .add(Duration(milliseconds: delay.toInt()), Tween(begin: 0.0, end: 0.0))
          .add(const Duration(milliseconds: 400), Tween(begin: 0.0, end: -20.0),
              curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(offset: Offset(0, animation['translateY']), child: child),
      ),
    );
  }
}

class ScaleDownFadeInAnimation extends StatelessWidget {
  const ScaleDownFadeInAnimation({this.delay = 1, this.child});

  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('scale').add(const Duration(milliseconds: 500), Tween(begin: 1.0, end: 2.0)),
      Track('opacity')
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(const Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(const Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.scale(
          scale: animation['scale'],
          child: child,
        ),
      ),
    );
  }
}

class FadeInAnimation extends StatelessWidget {
  const FadeInAnimation({this.delay = 01, this.child});

  final int delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween(
        [Track('opacity').add(const Duration(milliseconds: 300), Tween(begin: 0.0, end: 1.0))]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: child,
      ),
    );
  }
}

class FadeOutAnimation extends StatelessWidget {
  const FadeOutAnimation({this.delay = 01, this.animationDuration = 500, this.child});

  final int delay;
  final int animationDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Duration animDuration = Duration(milliseconds: animationDuration);
    final tween = MultiTrackTween([
      Track('opacity').add(animDuration, Tween(begin: 1.0, end: 0.0), curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: child,
      ),
    );
  }
}

class SlideInToastMessageAnimation extends StatelessWidget {
  const SlideInToastMessageAnimation(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track('translateY')
          .add(
            const Duration(milliseconds: 250),
            Tween(begin: -100.0, end: 0.0),
            curve: Curves.easeOut,
          )
          .add(const Duration(seconds: 1, milliseconds: 250), Tween(begin: 0.0, end: 0.0))
          .add(const Duration(milliseconds: 250), Tween(begin: 0.0, end: -100.0),
              curve: Curves.easeIn),
      Track('opacity')
          .add(const Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0))
          .add(const Duration(seconds: 1), Tween(begin: 1.0, end: 1.0))
          .add(const Duration(milliseconds: 500), Tween(begin: 1.0, end: 0.0)),
    ]);

    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(offset: Offset(0, animation['translateY']), child: child),
      ),
    );
  }
}
