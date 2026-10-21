import 'dart:math' as math;

import 'package:flutter/material.dart';

/// {@template character_image}
/// Виджет изображения персонажа.
/// {@endtemplate}
class CharacterImage extends StatelessWidget {
  /// {@macro character_image}
  const CharacterImage({super.key, required this.imageUrl, this.dimension});

  /// Url изображения персонажа.
  final String imageUrl;

  /// Размер отображаемого изображения.
  final double? dimension;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final minDimension = math.min(
          constraints.maxHeight,
          constraints.maxWidth,
        );

        if (minDimension < 80) {
          return Icon(
            Icons.image_not_supported,
            color: Theme.of(context).colorScheme.secondary,
          );
        }

        return Image.network(
          imageUrl,
          height: dimension,
          width: dimension,
          errorBuilder: (_, _, _) => Image.asset(
            "assets/images/empty.webp",
            height: dimension,
            width: dimension,
          ),
        );
      },
    );
  }
}
