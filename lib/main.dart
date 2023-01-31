import 'package:flutter/material.dart';
import 'package:flutter_introduction/dart_samples/dart_samples.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runDartSamples();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieWidget(),
    );
  }
}

class MovieWidget extends StatefulWidget {
  const MovieWidget({
    super.key,
  });

  @override
  State<MovieWidget> createState() => _MovieWidgetState();
}

class _MovieWidgetState extends State<MovieWidget> {
  bool _changed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _changed ? "Creed" : "Rocky Balboa",
            ),
          ),
          const SizedBox(height: 8),
          MaterialButton(
            onPressed: () {
              setState(() {
                _changed = !_changed;
              });
            },
            color: Colors.blue,
            child: const Text("Trocar!"),
          ),
        ],
      ),
    );
  }
}
