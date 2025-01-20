import 'dart:async';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Future<void> synchronous() async {
    try {
      throw Exception('エラー発生');
    } catch (error, _) {
      print('ここでキャッチできる');
      print('捕捉したエラー: $error');
    }
  }

  Future<void> asynchronous() async {
    try {
      Future<void>.delayed(Duration.zero).then((_) {
        throw Exception('エラー発生');
      });
    } catch (error, _) {
      print('ここでキャッチできない');
      print('捕捉したエラー: $error');
    }
  }

  Future<void> asynchronousWithRunZonedGuarded() async {
    runZonedGuarded(() {
      Future<void>.delayed(Duration.zero).then((_) {
        throw Exception('エラー発生');
      });
    }, (error, stackTrace) {
      print('ここでキャッチできる');
      print('捕捉したエラー: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  synchronous();
                },
                child: Text('同期的 + tryCatch')),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  asynchronous();
                },
                child: Text('非同期的 + tryCatch')),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async {
                  await runZonedGuarded(() async {
                    asynchronous();
                  }, (error, stackTrace) async {
                    print('ここでキャッチできる');
                    print(error);
                  });
                },
                child: Text('非同期的 + tryCatch + runZonedGuarded')),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  asynchronousWithRunZonedGuarded();
                },
                child: Text('非同期的 + runZonedGuarded')),
          ],
        ),
      ),
    );
  }
}
