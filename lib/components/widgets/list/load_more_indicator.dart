import 'package:flutter/material.dart';
import 'package:harpy/components/components.dart';

/// Builds a sliver for the end of a [CustomScrollView] indicating that more
/// data is being requested.
class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        padding: DefaultEdgeInsets.all(),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
