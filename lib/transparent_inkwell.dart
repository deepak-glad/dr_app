import 'package:flutter/material.dart';

import 'app_colors.dart';

class TransparentInkWell extends InkWell {
  const TransparentInkWell(
      {Key? key,
      Widget? child,
      required GestureTapCallback onTap,
      GestureTapCallback? onDoubleTap,
      GestureLongPressCallback? onLongPress,
      GestureTapDownCallback? onTapDown,
      GestureTapCancelCallback? onTapCancel,
      ValueChanged<bool>? onHighlightChanged,
      ValueChanged<bool>? onHover,
      InteractiveInkFeatureFactory? splashFactory,
      double? radius,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      bool enableFeedback = true,
      bool excludeFromSemantics = false})
      : super(
          key: key,
          child: child,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          focusColor: AppColors.colorTransparent,
          hoverColor: AppColors.colorTransparent,
          highlightColor: AppColors.colorTransparent,
          splashColor: AppColors.colorTransparent,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          customBorder: customBorder,
          enableFeedback: enableFeedback ?? true,
          excludeFromSemantics: excludeFromSemantics ?? false,
        );
}
