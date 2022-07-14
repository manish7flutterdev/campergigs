import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final width, height, source;
  CustomImage(this.width, this.height, this.source);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 200,
        minWidth: 300,
        maxHeight: 600,
        maxWidth: 600,
      ),
      child: Container(
        width: width,
        height: height,
        child: Image.asset(
          source,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

// ConstrainedBox(
//       constraints: BoxConstraints(
//         minHeight: 200,
//         minWidth: 300,
//         maxHeight: 600,
//         maxWidth: 600,
//       ),
//       child: Container(
//         width: width,
//         height: height,
//         child: Image.asset(source),
//       ),
//     )