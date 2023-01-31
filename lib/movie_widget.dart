import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
  });

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
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
