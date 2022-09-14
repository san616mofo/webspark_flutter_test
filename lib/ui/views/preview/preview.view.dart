import 'package:flutter/material.dart';
import 'package:webspark_test/ui/shared/widgets/shortest_route.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  final List<List<String>> _data = [
    ["0,0", "1,0", "2,0", "3,0"],
    ["0,1", "1,1", "2,1", "3,1"],
    ["0,2", "1,2", "2,2", "3,2"],
    ["0,3", "1,3", "2,3", "3,3"],
  ];

  final List<String> _path = ["0,3", "1,2", "2,1", "3,0"];

  //   ¯⁠\⁠_⁠(⁠ ͡⁠°⁠ ͜⁠ʖ⁠ ͡⁠°⁠)⁠_⁠/⁠¯
  Color? _prosto(int row, int element) {
    Color? color;
    switch (row) {
      case 0:
        switch (element) {
          case 0:
            color = GridElements.emptyCell;
            break;
          case 1:
            color = GridElements.emptyCell;
            break;
          case 2:
            color = GridElements.emptyCell;
            break;
          case 3:
            color = GridElements.endCell;
            break;
        }
        break;
      case 1:
        switch (element) {
          case 0:
            color = GridElements.emptyCell;
            break;
          case 1:
            color = GridElements.emptyCell;
            break;
          case 2:
            color = GridElements.shortestPathCell;
            break;
          case 3:
            color = GridElements.emptyCell;
            break;
        }
        break;
      case 2:
        switch (element) {
          case 0:
            color = GridElements.emptyCell;
            break;
          case 1:
            color = GridElements.shortestPathCell;
            break;
          case 2:
            color = GridElements.emptyCell;
            break;
          case 3:
            color = GridElements.emptyCell;
            break;
        }
        break;
      case 3:
        switch (element) {
          case 0:
            color = GridElements.startCell;
            break;
          case 1:
            color = GridElements.emptyCell;
            break;
          case 2:
            color = GridElements.emptyCell;
            break;
          case 3:
            color = GridElements.emptyCell;
            break;
        }
        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _grid(),
            const SizedBox(height: 20),
            ShortestRoute(list: _path),
          ],
        ),
      ),
    );
  }

  Widget _grid() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: _data[0].length,
      children: [
        for (var row in _data)
          for (var item in row)
            GridTile(
              child: Card(
                color: _prosto(_data.indexOf(row), row.indexOf(item)),
                child: Center(
                  child: Text("($item)"),
                ),
              ),
            ),
      ],
    );
  }
}

class GridElements {
  static const Color startCell = Color(0xFF64FFDA);
  static const Color endCell = Color(0xFF009688);
  static const Color blockedCell = Color(0xFF000000);
  static const Color shortestPathCell = Color(0xFF4CAF50);
  static const Color emptyCell = Color(0xFFFFFFFF);
}
