import 'package:fluid/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FluidAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 28),
      color: Colors.white.withOpacity(0.98),

      child: SafeArea(
        top: true,
        bottom: false,
        child: Row(
          children: [
            SvgPicture.asset(Assets.drawer, width: 20),
            SizedBox(width: 24),

            Expanded(
              child: Row(
                children: [
                  Text(
                    "Featured",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
            SvgPicture.asset(Assets.row, width: 16),
            SizedBox(width: 4),

            SvgPicture.asset(Assets.column, width: 16),

            SizedBox(width: 12),
            SvgPicture.asset(Assets.search, width: 20),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return maxExtent != oldDelegate.maxExtent ||
        minExtent != oldDelegate.minExtent;
  }
}
