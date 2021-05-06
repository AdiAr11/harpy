import 'package:flutter/material.dart';
import 'package:harpy/harpy_widgets/harpy_widgets.dart';

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle();

  @override
  Widget build(BuildContext context) {
    final harpyTheme = HarpyTheme.of(context);

    return Container(
      width: 40,
      height: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: kDefaultBorderRadius,
        color: harpyTheme.foregroundColor.withOpacity(.2),
      ),
    );
  }
}
