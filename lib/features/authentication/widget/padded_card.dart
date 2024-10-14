
import 'package:flutter/material.dart';
import 'package:pinkaid/separated/separated_list.dart';
import 'package:pinkaid/theme/theme.dart';


class PaddedCard extends StatelessWidget {
  const PaddedCard({
    super.key,
    required this.children,
    this.margin = const EdgeInsets.only(
      left: kSpaceScreenPadding,
      right: kSpaceScreenPadding,
      bottom: kSpaceSectionSm,
    ),
    this.padding = const EdgeInsets.symmetric(
      horizontal: kSpaceSectionMd,
      vertical: kSpaceSectionLg,
    ),
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.separator = const SizedBox(height: kSpaceSectionMd),
    this.axis = Axis.vertical,
  });

  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final Widget? separator;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin ?? EdgeInsets.zero,
      child: SeparatedList(
        separator: separator,
        mainAxisSize: MainAxisSize.min,
        padding: padding,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        axis: axis,
        children: children,
      ),
    );
  }
}