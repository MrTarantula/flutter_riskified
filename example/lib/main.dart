import 'package:flutter/material.dart';
import 'package:flutter_riskified/flutter_riskified.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = 'Select an action';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Riskified Example'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              ElevatedButton(
                  child: Text("Start Beacon"),
                  onPressed: () async {
                    await Riskified.startBeacon("test", "test",
                        debugInfo: true);
                    _updateText('Beacon started!');
                  }),
              ElevatedButton(
                  child: Text("Log Request"),
                  onPressed: () async {
                    await Riskified.logRequest("https://www.test.com/test");
                    _updateText('Request logged!');
                  }),
              ElevatedButton(
                  child: Text("Update Session Token"),
                  onPressed: () async {
                    await Riskified.updateSessionToken("abcdefg");
                    _updateText('Session token updated!');
                  }),
              ElevatedButton(
                  child: Text("Log Sensitive Device Info"),
                  onPressed: () async {
                    await Riskified.logSensitiveDeviceInfo();
                    _updateText('Sensitive device info logged!');
                  }),
              ElevatedButton(
                  child: Text("Device ID"),
                  onPressed: () async {
                    _updateText(
                        'Device ID: ${await Riskified.riskifiedDeviceId}');
                  }),
              Text(_text)
            ]),
          ],
        ),
      ),
    );
  }

  _updateText(String text) => setState(() {
        _text = text;
      });
}
