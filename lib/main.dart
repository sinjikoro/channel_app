import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Native Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryLevel = 'Unknown battery level';

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/buttery');

    String batteryLevel = '';
    try {
      int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = result.toString();
    } on PlatformException catch (error) {
      setState(() {
        batteryLevel = 'Failed to get battery level: $error';
      });
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text('Battery Level: $_batteryLevel')),
    );
  }
}
