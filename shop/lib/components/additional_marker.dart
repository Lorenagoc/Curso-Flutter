import 'package:flutter/material.dart';

class AdditionalMarker extends StatelessWidget {
  final Widget child;
  final String values;
  final Color? color;
  const AdditionalMarker(
      {super.key, required this.child, required this.values, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: color ?? Colors.black,
            ),
            constraints: const BoxConstraints(
              minHeight: 16,
              maxHeight: 16,
            ),
            child: Text(
              values,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
