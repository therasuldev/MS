import 'package:flutter/material.dart';

import '../../mystore.dart';

class AnimePressButton extends StatefulWidget {
  final void Function() onTap;
  final Widget title;
  final Duration? duration;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<Shadow>? boxShadow;
  final Color? color;
  final Color? titleColor;
  final double? titleSize;
  final FontWeight? fontWeight;

  const AnimePressButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.duration,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.titleColor,
    this.titleSize,
    this.fontWeight,
  }) : super(key: key);
  @override
  _AnimePressButtonState createState() => _AnimePressButtonState();
}

class _AnimePressButtonState extends State<AnimePressButton>
    with SingleTickerProviderStateMixin {
  double? _scale;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: (widget.duration != null)
          ? widget.duration
          : const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 0.1,
    );

    _animationController!.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController!.value;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        _animationController!.forward();
      },
      onTapCancel: () {
        _animationController!.reverse();
      },
      onTapUp: (details) {
        _animationController!.reverse();
      },
      child: Transform.scale(
        scale: _scale!,
        child: buttonBody(),
      ),
    );
  }

  Widget buttonBody() {
    return Container(
      height: (widget.height != null) ? widget.height : 55,
      width: (widget.width != null) ? widget.width : 200,

      ///
      decoration: boxDecoration(),
      child: Center(
        child: widget.title,
      ),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      color: lightBlueColor,
      borderRadius: (widget.borderRadius != null)
          ? widget.borderRadius
          : BorderRadius.circular(10),
    );
  }
}
