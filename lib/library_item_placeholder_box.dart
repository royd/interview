import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LibraryItemPlaceholderBox extends StatelessWidget {
  const LibraryItemPlaceholderBox({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
      ),
    );
  }
}
