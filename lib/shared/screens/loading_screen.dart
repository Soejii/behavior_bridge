import 'package:flutter/material.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.brand.bg,
      body: Center(
        child: CircularProgressIndicator(
          color: context.brand.accent,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
