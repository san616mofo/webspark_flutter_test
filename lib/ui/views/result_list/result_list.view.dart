import 'package:flutter/material.dart';
import 'package:webspark_test/core/models/index.dart';
import 'package:webspark_test/ui/shared/widgets/index.dart';
import 'package:webspark_test/ui/views/index.dart';

class ResultListPage extends StatefulWidget {
  final List<CalculationGetModel> _data;

  const ResultListPage(this._data, {super.key});

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  late Map<String, bool> isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = defaultSelectedValue();
  }

  Map<String, bool> defaultSelectedValue() {
    Map<String, bool> result = {};
    for (int i = 0; i < widget._data.length; i++) {
      result[widget._data[i].id] = false;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result list screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _list(),
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget._data.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (isSelected[widget._data[index].id] == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PreviewPage(),
                ),
              );
            }
            setState(() {
              isSelected[widget._data[index].id] = true;
            });
          },
          child: Container(
            color: !isSelected[widget._data[index].id]! ? Colors.black : null,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ShortestRoute(
              list: widget._data[index].field,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 1.0,
        );
      },
    );
  }
}
