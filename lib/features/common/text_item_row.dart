import 'package:flutter/material.dart';

class TextItemRow extends StatelessWidget {
  const TextItemRow({
    required this.left,
    required this.right,
    Key? key,
  }) : super(key: key);

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            left,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: Text(
            right,
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }
}
