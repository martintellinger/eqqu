import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final String imageAsset;
  final int totalImages;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final String heroTag;
  final ColorScheme colorScheme;

  const ImageCarousel({
    super.key,
    required this.imageAsset,
    required this.totalImages,
    required this.currentIndex,
    required this.onPageChanged,
    this.heroTag = '',
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageArea = AspectRatio(
      aspectRatio: 177 / 200,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: totalImages,
            onPageChanged: onPageChanged,
            itemBuilder: (_, index) {
              if (imageAsset.isNotEmpty) {
                return Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }
              return Container(
                color: colorScheme.surfaceContainerLow,
                child: Icon(
                  Icons.image_outlined,
                  size: 64,
                  color: colorScheme.tertiary.withValues(alpha: 0.3),
                  semanticLabel: 'No image available',
                ),
              );
            },
          ),
          // Top gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 116,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.35, 1.0],
                  colors: [
                    Color(0x80000000),
                    Color(0x404E4E4E),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Bottom gradient
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.12, 0.28, 1.0],
                  colors: [
                    Color(0x80000000),
                    Color(0x40000000),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Animated page indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalImages, (i) {
                final isActive = i == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: isActive ? 32 : 8,
                  height: 8,
                  margin: EdgeInsets.only(left: i > 0 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.5),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );

    if (heroTag.isNotEmpty) {
      imageArea = Hero(
        tag: heroTag,
        flightShuttleBuilder: (_, animation, direction, fromContext, toContext) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final borderRadius = BorderRadius.lerp(
                BorderRadius.circular(4),
                BorderRadius.zero,
                animation.value,
              )!;
              return ClipRRect(
                borderRadius: borderRadius,
                child: imageAsset.isNotEmpty
                    ? Image.asset(
                        imageAsset,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : Container(color: colorScheme.surfaceContainerLow),
              );
            },
          );
        },
        child: Material(
          type: MaterialType.transparency,
          child: imageArea,
        ),
      );
    }

    return imageArea;
  }
}
