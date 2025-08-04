import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'flippable_tween_sequence.dart';
import 'hide_able.dart';

class FluidRoute<T> extends PageRoute<T> {
  FluidRoute({
    required this.color,

    required ShapeBorder closedShape,
    required this.openShape,
    required this.closedBuilder,
    required this.openBuilder,
    required this.hideAbleKey,
    required this.closedBuilderKey,
    required this.transitionDuration,
    required this.transitionType,
    required this.useRootNavigator,
    required RouteSettings? routeSettings,
  }) : _shapeTween = ShapeBorderTween(begin: closedShape, end: openShape),

       _closedOpacityTween = _getClosedOpacityTween(transitionType),
       _openOpacityTween = _getOpenOpacityTween(transitionType),
       super(settings: routeSettings);

  static FlippableTweenSequence<double> _getClosedOpacityTween(
    ContainerTransitionType transitionType,
  ) {
    switch (transitionType) {
      case ContainerTransitionType.fade:
        return FlippableTweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(1.0),
            weight: 1,
          ),
        ]);
      case ContainerTransitionType.fadeThrough:
        return FlippableTweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 1.0, end: 0.0),
            weight: 1 / 5,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(0.0),
            weight: 4 / 5,
          ),
        ]);
    }
  }

  static FlippableTweenSequence<double> _getOpenOpacityTween(
    ContainerTransitionType transitionType,
  ) {
    switch (transitionType) {
      case ContainerTransitionType.fade:
        return FlippableTweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(0.0),
            weight: 1 / 5,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            weight: 1 / 5,
          ),
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(1.0),
            weight: 3 / 5,
          ),
        ]);
      case ContainerTransitionType.fadeThrough:
        return FlippableTweenSequence<double>(<TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: ConstantTween<double>(0.0),
            weight: 1 / 5,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            weight: 4 / 5,
          ),
        ]);
    }
  }

  final Color color;
  final ShapeBorder openShape;
  final CloseContainerBuilder closedBuilder;
  final OpenContainerBuilder<T> openBuilder;

  // See [_FluidState._hideAbleKey].
  final GlobalKey<HideAbleState> hideAbleKey;

  // See [_FluidState._closedBuilderKey].
  final GlobalKey closedBuilderKey;

  @override
  final Duration transitionDuration;
  final ContainerTransitionType transitionType;

  final bool useRootNavigator;

  final ShapeBorderTween _shapeTween;
  final FlippableTweenSequence<double> _closedOpacityTween;
  final FlippableTweenSequence<double> _openOpacityTween;

  // Key used for the widget returned by [Fluid.openBuilder] to keep
  // its state when the shape of the widget tree is changed at the end of the
  // animation to remove all the craft that was necessary to make the animation
  // work.
  final GlobalKey _openBuilderKey = GlobalKey();

  // Defines the position and the size of the (opening) [Fluid] within
  // the bounds of the enclosing [Navigator].
  final RectTween _rectTween = RectTween();

  AnimationStatus? _lastAnimationStatus;
  AnimationStatus? _currentAnimationStatus;

  @override
  TickerFuture didPush() {
    _takeMeasurements(navigatorContext: hideAbleKey.currentContext!);

    animation!.addStatusListener((AnimationStatus status) {
      _lastAnimationStatus = _currentAnimationStatus;
      _currentAnimationStatus = status;
      switch (status) {
        case AnimationStatus.dismissed:
          _toggleHideable(hide: false);
        case AnimationStatus.completed:
          _toggleHideable(hide: true);
        case AnimationStatus.forward:
        case AnimationStatus.reverse:
          break;
      }
    });

    return super.didPush();
  }

  @override
  bool didPop(T? result) {
    _takeMeasurements(
      navigatorContext: subtreeContext!,
      delayForSourceRoute: true,
    );
    return super.didPop(result);
  }

  @override
  void dispose() {
    if (hideAbleKey.currentState?.isVisible == false) {
      // This route may be disposed without dismissing its animation if it is
      // removed by the navigator.
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration d) => _toggleHideable(hide: false),
      );
    }
    super.dispose();
  }

  void _toggleHideable({required bool hide}) {
    if (hideAbleKey.currentState != null) {
      hideAbleKey.currentState!
        ..placeholderSize = null
        ..isVisible = !hide;
    }
  }

  void _takeMeasurements({
    required BuildContext navigatorContext,
    bool delayForSourceRoute = false,
  }) {
    final RenderBox navigator =
        Navigator.of(
              navigatorContext,
              rootNavigator: useRootNavigator,
            ).context.findRenderObject()!
            as RenderBox;
    final Size navSize = _getSize(navigator);
    _rectTween.end = Offset.zero & navSize;

    void takeMeasurementsInSourceRoute([Duration? _]) {
      if (!navigator.attached || hideAbleKey.currentContext == null) {
        return;
      }
      _rectTween.begin = _getRect(hideAbleKey, navigator);
      hideAbleKey.currentState!.placeholderSize = _rectTween.begin!.size;
    }

    if (delayForSourceRoute) {
      SchedulerBinding.instance.addPostFrameCallback(
        takeMeasurementsInSourceRoute,
      );
    } else {
      takeMeasurementsInSourceRoute();
    }
  }

  Size _getSize(RenderBox render) {
    assert(render.hasSize);
    return render.size;
  }

  // Returns the bounds of the [RenderObject] identified by `key` in the
  // coordinate system of `ancestor`.
  Rect _getRect(GlobalKey key, RenderBox ancestor) {
    assert(key.currentContext != null);
    assert(ancestor.hasSize);
    final RenderBox render =
        key.currentContext!.findRenderObject()! as RenderBox;
    assert(render.hasSize);
    return MatrixUtils.transformRect(
      render.getTransformTo(ancestor),
      Offset.zero & render.size,
    );
  }

  bool get _transitionWasInterrupted {
    bool wasInProgress = false;
    bool isInProgress = false;

    switch (_currentAnimationStatus) {
      case AnimationStatus.completed:
      case AnimationStatus.dismissed:
        isInProgress = false;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        isInProgress = true;
      case null:
        break;
    }
    switch (_lastAnimationStatus) {
      case AnimationStatus.completed:
      case AnimationStatus.dismissed:
        wasInProgress = false;
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        wasInProgress = true;
      case null:
        break;
    }
    return wasInProgress && isInProgress;
  }

  void closeContainer({T? returnValue}) {
    Navigator.of(subtreeContext!).pop(returnValue);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Align(
      alignment: Alignment.topLeft,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          if (animation.isCompleted) {
            return SizedBox.expand(
              child: Material(
                color: color,
                shape: openShape,
                child: Builder(
                  key: _openBuilderKey,
                  builder: (BuildContext context) {
                    return openBuilder(context, closeContainer);
                  },
                ),
              ),
            );
          }

          final Animation<double> curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
            reverseCurve: _transitionWasInterrupted
                ? null
                : Curves.fastOutSlowIn.flipped,
          );
          TweenSequence<double>? closedOpacityTween, openOpacityTween;

          switch (animation.status) {
            case AnimationStatus.dismissed:
            case AnimationStatus.forward:
              closedOpacityTween = _closedOpacityTween;
              openOpacityTween = _openOpacityTween;

            case AnimationStatus.reverse:
              if (_transitionWasInterrupted) {
                closedOpacityTween = _closedOpacityTween;
                openOpacityTween = _openOpacityTween;

                break;
              }
              closedOpacityTween = _closedOpacityTween.flipped;
              openOpacityTween = _openOpacityTween.flipped;

            case AnimationStatus.completed:
              assert(false); // Unreachable.
          }
          assert(closedOpacityTween != null);
          assert(openOpacityTween != null);

          final Rect rect = _rectTween.evaluate(curvedAnimation)!;
          return SizedBox.expand(
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.translate(
                offset: Offset(rect.left, rect.top),
                child: SizedBox(
                  width: rect.width,
                  height: rect.height,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    animationDuration: Duration.zero,
                    color: color,
                    shape: _shapeTween.evaluate(curvedAnimation),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        // Closed child fading out.
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: _rectTween.begin!.width,
                            height: _rectTween.begin!.height,
                            child: (hideAbleKey.currentState?.isInTree ?? false)
                                ? null
                                : FadeTransition(
                                    opacity: closedOpacityTween!.animate(
                                      animation,
                                    ),
                                    child: Builder(
                                      key: closedBuilderKey,
                                      builder: (BuildContext context) {
                                        // Use dummy "open container" callback
                                        // since we are in the process of opening.
                                        return closedBuilder(context, () {});
                                      },
                                    ),
                                  ),
                          ),
                        ),

                        // Open child fading in.
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: _rectTween.end!.width,
                            height: _rectTween.end!.height,
                            child: FadeTransition(
                              opacity: openOpacityTween!.animate(animation),
                              child: Builder(
                                key: _openBuilderKey,
                                builder: (BuildContext context) {
                                  return openBuilder(context, closeContainer);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Color? get barrierColor => null;

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;
}
