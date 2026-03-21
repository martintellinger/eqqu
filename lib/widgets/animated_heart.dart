import 'dart:math';
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
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _particleController;
  late Animation<double> _scaleAnimation;
  bool _showParticles = false;

  static final _random = Random();

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 700),
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
    _particleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    final willBeFav = !widget.isFavorite;
    widget.onToggle();
    _scaleController.forward(from: 0);
    if (willBeFav) {
      setState(() => _showParticles = true);
      _particleController.forward(from: 0).then((_) {
        if (mounted) setState(() => _showParticles = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox(
            width: widget.circleSize + 16,
            height: widget.circleSize + 16,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                if (_showParticles)
                  AnimatedBuilder(
                    animation: _particleController,
                    builder: (context, _) => CustomPaint(
                      size: Size(widget.circleSize + 16, widget.circleSize + 16),
                      painter: _ParticlePainter(
                        progress: _particleController.value,
                        color: widget.cs.error,
                        accentColor: widget.cs.surfaceTint,
                      ),
                    ),
                  ),
                AnimatedBuilder(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color accentColor;

  static final _random = Random(42);
  static final List<_Particle> _particles = List.generate(12, (i) {
    final angle = (i / 12) * 2 * pi + _random.nextDouble() * 0.5;
    final speed = 0.6 + _random.nextDouble() * 0.6;
    final size = 1.5 + _random.nextDouble() * 2.0;
    final isHeart = i % 3 == 0;
    return _Particle(angle: angle, speed: speed, size: size, isHeart: isHeart);
  });

  _ParticlePainter({
    required this.progress,
    required this.color,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final opacity = (1.0 - progress).clamp(0.0, 1.0);

    for (final p in _particles) {
      final distance = p.speed * progress * 24;
      final x = center.dx + cos(p.angle) * distance;
      final y = center.dy + sin(p.angle) * distance - progress * 8;
      final currentSize = p.size * (1.0 - progress * 0.5);
      final particleColor = p.isHeart ? color : accentColor;

      final paint = Paint()
        ..color = particleColor.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;

      if (p.isHeart) {
        _drawMiniHeart(canvas, Offset(x, y), currentSize, paint);
      } else {
        canvas.drawCircle(Offset(x, y), currentSize, paint);
      }
    }
  }

  void _drawMiniHeart(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    final s = size * 1.2;
    path.moveTo(center.dx, center.dy + s * 0.3);
    path.cubicTo(
      center.dx - s, center.dy - s * 0.3,
      center.dx - s * 0.5, center.dy - s,
      center.dx, center.dy - s * 0.4,
    );
    path.cubicTo(
      center.dx + s * 0.5, center.dy - s,
      center.dx + s, center.dy - s * 0.3,
      center.dx, center.dy + s * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final bool isHeart;

  const _Particle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.isHeart,
  });
}
