import 'package:flutter/material.dart';

class StatusDot extends StatelessWidget {
  const StatusDot({
    Key? key,
    required this.status,
    this.size = 8
  }) : super(key: key);

  final String status;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: status == "Alive"
            ? Colors.green
            : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}