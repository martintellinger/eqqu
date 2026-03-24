import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedHeartButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onToggle;
  final ColorScheme cs;
  final double iconSize;
  final double circleSize;

  const AnimatedHeartButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    required this.cs,
    this.iconSize = 16,
    this.circleSize = 32,
  });

  @override
  State<AnimatedHeartButton> createState() => _AnimatedHeartButtonState();
}

class _AnimatedHeartButtonState extends State<AnimatedHeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.25), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.25, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onToggle();
    _scaleController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.circleSize > 0 ? widget.circleSize + 16 : 48.0;

    return Semantics(
      label: widget.isFavorite ? 'Remove from favorites' : 'Add to favorites',
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _handleTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (widget.circleSize > 0)
                    Container(
                      width: widget.circleSize,
                      height: widget.circleSize,
                      decoration: BoxDecoration(
                        color: widget.cs.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                    ),
                  SvgPicture.asset(
                    widget.isFavorite
                        ? 'assets/icons/Heart.svg'
                        : 'assets/icons/HeartEmpty.svg',
                    width: widget.iconSize,
                    height: widget.iconSize,
                    colorFilter: ColorFilter.mode(
                      widget.isFavorite
                          ? widget.cs.error
                          : widget.circleSize > 0
                              ? widget.cs.onSecondaryContainer
                              : widget.cs.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
