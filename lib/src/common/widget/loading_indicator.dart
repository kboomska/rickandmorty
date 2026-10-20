import 'package:flutter/material.dart';

/// {@template loading_indicator}
/// Виджет состояния загрузки.
/// {@endtemplate}
class LoadingIndicator extends StatelessWidget {
  /// {@macro loading_indicator}
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 40,
        child: RepaintBoundary(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }
}
