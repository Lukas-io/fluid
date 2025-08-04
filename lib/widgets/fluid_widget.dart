import 'package:animations/animations.dart';
import 'package:fluid/core/fluid_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprung/sprung.dart';

import '../core/hide_able.dart';
import '../cubit/post_cubit.dart';

@optionalTypeArgs
class FluidWidget<T extends Object?> extends StatefulWidget {
  const FluidWidget({
    super.key,
    this.color,
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    this.openShape = const RoundedRectangleBorder(),
    this.onClosed,
    required this.closedBuilder,
    required this.openBuilder,
    this.tappable = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.useRootNavigator = false,
    this.routeSettings,
    this.clipBehavior = Clip.antiAlias,
    required this.transitionType,
  });

  final Color? color;

  final ShapeBorder closedShape;

  final ShapeBorder openShape;

  final ClosedCallback<T?>? onClosed;

  final CloseContainerBuilder closedBuilder;

  final OpenContainerBuilder<T> openBuilder;

  final bool tappable;

  final Duration transitionDuration;

  /// The type of fade transition that the container will use for its
  /// incoming and outgoing widgets.
  ///
  /// Defaults to [ContainerTransitionType.fade].
  final ContainerTransitionType transitionType;

  /// The [useRootNavigator] argument is used to determine whether to push the
  /// route for [openBuilder] to the Navigator furthest from or nearest to
  /// the given context.
  ///
  /// By default, [useRootNavigator] is false and the route created will push
  /// to the nearest navigator.
  final bool useRootNavigator;

  /// Provides additional data to the [openBuilder] route pushed by the Navigator.
  final RouteSettings? routeSettings;

  /// The [closedBuilder] will be clipped (or not) according to this option.
  ///
  /// Defaults to [Clip.antiAlias], and must not be null.
  ///
  /// See also:
  ///
  ///  * [Material.clipBehavior], which is used to implement this property.
  final Clip clipBehavior;

  @override
  State<FluidWidget<T?>> createState() => _FluidWidgetState<T>();
}

class _FluidWidgetState<T> extends State<FluidWidget<T?>> {
  // Key used in [_FluidWidgetRoute] to hide the widget returned by
  // [FluidWidget.openBuilder] in the source route while the container is
  // opening/open. A copy of that widget is included in the
  // [_FluidWidgetRoute] where it fades out. To avoid issues with double
  // shadows and transparency, we hide it in the source route.
  final GlobalKey<HideAbleState> hideAbleKey = GlobalKey<HideAbleState>();

  // Key used to steal the state of the widget returned by
  // [FluidWidget.openBuilder] from the source route and attach it to the
  // same widget included in the [_FluidWidgetRoute] where it fades out.
  final GlobalKey _closedBuilderKey = GlobalKey();

  late AnimationController _animationController;

  Future<void> fluidContainer(context) async {
    final Color color = widget.color ?? Theme.of(context).canvasColor;
    final T? data =
        await Navigator.of(
          context,
          rootNavigator: widget.useRootNavigator,
        ).push(
          FluidRoute<T>(
            color: color,

            closedShape: widget.closedShape,
            openShape: widget.openShape,
            closedBuilder: widget.closedBuilder,
            openBuilder: widget.openBuilder,
            hideAbleKey: hideAbleKey,
            closedBuilderKey: _closedBuilderKey,
            transitionDuration: widget.transitionDuration,
            transitionType: widget.transitionType,
            useRootNavigator: widget.useRootNavigator,
            routeSettings: widget.routeSettings,
          ),
        );
    if (widget.onClosed != null) {
      widget.onClosed!(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HideAble(
      key: hideAbleKey,
      child: GestureDetector(
        onTap: widget.tappable
            ? () async {
                context.read<PostCubit>().hideHeader();

                _animationController.forward();
                await Future.delayed(200.ms);
                _animationController.reverse();

                if (mounted) fluidContainer(context);
              }
            : null,
        child:
            Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    clipBehavior: widget.clipBehavior,
                    color: widget.color,
                    shape: widget.closedShape,
                    child: Builder(
                      key: _closedBuilderKey,
                      builder: (BuildContext _) {
                        return widget.closedBuilder(
                          context,
                          () => fluidContainer(context),
                        );
                      },
                    ),
                  ),
                )
                .animate(
                  onInit: (controller) {
                    _animationController = controller;
                  },
                  autoPlay: false,
                )
                .scale(
                  begin: Offset(1, 1),
                  end: Offset(0.9, 0.9),
                  duration: 300.ms,
                  curve: Sprung(32),
                ),
      ),
    );
  }
}
