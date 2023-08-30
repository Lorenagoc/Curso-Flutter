import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: const Text('Nenhuma imagem'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(
              Icons.camera_alt_rounded,
              color: Colors.blue,
            ),
            label: const Text(
              "Tirar foto",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
