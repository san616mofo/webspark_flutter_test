import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webspark_test/ui/views/index.dart';
import 'package:webspark_test/ui/shared/widgets/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<TextEditingController> _urlList = <TextEditingController>[];
  String _error = "";

  Future<bool> _apiRequest() async {
    Uri url = Uri.parse(_controller.text);
    if (await canLaunchUrl(url)) {
      return true;
    } else {
      return false;
    }
  }

  void _removeError(String? value) {
    if (value != null) {
      setState(() {
        _error = "";
      });
    }
  }

  void _removeFromList(String value) {
    if (value.isEmpty) {
      setState(() {
        _urlList.removeWhere(((element) => element.text == value));
      });
    }
  }

  void _onStartCountingProcess() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (await _apiRequest() == true) {
      setState(() {
        _urlList.add(TextEditingController()..text = _controller.text);
      });
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProcessPage(_controller.text),
        ),
      );
      _controller.text = "";
    } else {
      setState(() {
        _error = "Enter valid URL";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home screen"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _header(),
                    const SizedBox(height: 25.0),
                    _textField(
                      controller: _controller,
                      onChanged: _removeError,
                    ),
                    const SizedBox(height: 20.0),
                    ..._textFieldList(),
                    const Spacer(),
                    _errorText(),
                    const SizedBox(height: 25.0),
                    Button(
                      text: "Start counting process",
                      isActive: true,
                      onPressed: _onStartCountingProcess,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _header() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Set valid API base URL in order to continue",
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
  }

  List<Widget> _textFieldList() {
    return _urlList
        .map(
          (TextEditingController url) => Padding(
            padding: EdgeInsets.only(
              bottom: _urlList.last != url ? 20.0 : 0,
            ),
            child: _textField(
              controller: url,
              onChanged: _removeFromList,
            ),
          ),
        )
        .toList();
  }

  Widget _textField({
    required TextEditingController controller,
    required void Function(String) onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.swap_horiz,
          color: Colors.black,
          size: 24.0,
        ),
        const SizedBox(width: 30.0),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              hintText: "Enter url",
              hintStyle: TextStyle(
                color: Colors.grey[550],
              ),
              isDense: true,
              contentPadding: const EdgeInsets.only(bottom: 10.0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue[300]!,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue[300]!,
                  width: 2,
                ),
              ),
            ),
          ),
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
