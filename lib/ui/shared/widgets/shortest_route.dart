import 'package:flutter/material.dart';

class ShortestRoute extends StatelessWidget {
  final List<String> list;

  const ShortestRoute({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (int index = 0; index < list.length; index++)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "(${list[index]})",
                style: const TextStyle(fontSize: 18),
              ),
              if (index != list.length - 1) const Text("-->"),
            ],
          ),
      ],
    );
  }
}
