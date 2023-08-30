import 'package:dots_progress_indicator/dots_progress_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Example app
class MyApp extends StatelessWidget {
  /// Example app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dots progress indicator Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dots progress indicator Demo'),
    );
  }
}

/// Example home page
class MyHomePage extends StatefulWidget {
  /// Example home page
  const MyHomePage({required this.title, super.key});

  /// The title shown in the app bar
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DotsProgressIndicator(),
            SizedBox(height: 20),
            DotsProgressIndicator(
              backgroundColor: Colors.black12,
              color: Colors.blue,
              curve: Curves.bounceIn,
              dotDiameter: 20,
              duration: Duration(milliseconds: 1000),
              numberOfDots: 5,
              spaceBetween: 4,
            ),
          ],
        ),
      ),
    );
  }
}
