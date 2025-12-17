import 'package:flutter/material.dart';

class GoldenWrapper extends StatelessWidget {
  final Widget child;
  final Size? surfaceSize;
  final Color? backgroundColor;
  final bool wrapWithMaterialApp;

  const GoldenWrapper({
    Key? key,
    required this.child,
    this.surfaceSize,
    this.backgroundColor,
    this.wrapWithMaterialApp = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default size if not provided
    final size = surfaceSize ?? const Size(800, 600);

    Widget content = Center(
      child: RepaintBoundary(
        child: child,
      ),
    );

    if (wrapWithMaterialApp) {
      content = MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Scaffold(
          backgroundColor: backgroundColor ?? Colors.white,
          body: content,
        ),
      );
    } else {
      // If not wrapping with MaterialApp, we still need a directionality and potentially a colored container
      content = Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          color: backgroundColor ?? Colors.white,
          child: content,
        ),
      );
    }

    // Force layout size
    return Center(
      child: SizedBox.fromSize(
        size: size,
        child: content,
      ),
    );
  }
}
