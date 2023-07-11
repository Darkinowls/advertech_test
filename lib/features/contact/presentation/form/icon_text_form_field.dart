import 'package:flutter/material.dart';

class IconTextFormField extends StatelessWidget {
  final Widget child;

  const IconTextFormField({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 245, 233, 1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.lock_open,
              color: Color.fromRGBO(229, 190, 144, 1)),
        ),
        const SizedBox(width: 15),
        Expanded(child: child),
      ],
    );
  }
}
