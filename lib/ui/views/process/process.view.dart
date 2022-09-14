import 'package:flutter/material.dart';
import 'package:webspark_test/core/apis/index.dart';
import 'package:webspark_test/core/models/index.dart';
import 'package:webspark_test/ui/views/index.dart';
import 'package:webspark_test/ui/shared/widgets/index.dart';

class ProcessPage extends StatefulWidget {
  final String url;

  const ProcessPage(
    this.url, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  late List<CalculationGetModel> _calculationList;
  bool _isLoading = false;
  bool _isActiveButton = true;
  String _error = "";

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await CalculationProvider.getCalculationResults(widget.url).then(
      (value) {
        _calculationList = value;
        setState(() {
          _isLoading = true;
        });
      },
    );
  }

  void _onSendResultsToServer() async {
    // TODO: backend error
    // "code": 500, "message": "Not valid test ID"
    // but i use String, like "7d785c38-cd54-4a98-ab57-44e50ae646c1"

    // setState(() {
    //   _isActiveButton = false;
    //   _error = "";
    // });
    // await CalculationProvider.postCalculationResult().then((value) {
    //   setState(() {
    //     _isActiveButton = true;
    //   });
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ResultListPage(_calculationList),
    //     ),
    //   );
    // }).onError((error, stackTrace) {
    //   setState(() {
    //     _isActiveButton = true;
    //     _error = error.toString();
    //   });
    // });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultListPage(_calculationList),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Process screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _loading(),
            ),
            _errorText(),
            const SizedBox(height: 25.0),
            if (_isLoading)
              Button(
                text: "Send results to server",
                isActive: _isActiveButton,
                onPressed: _onSendResultsToServer,
              ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "All calculations has finished, you can send your results to server",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          direction: Axis.vertical,
          spacing: 10.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              _isLoading ? "100%" : "0%",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                color: Colors.blue[300]!,
                value: _isLoading ? 1.0 : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _errorText() {
    return Text(
      _error,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}
