import 'dart:async';

import 'package:flutter/material.dart';

class RunZonedPage extends StatefulWidget {
  const RunZonedPage({super.key, required this.title});
  final String title;

  @override
  State<RunZonedPage> createState() => _RunZonedPageState();
}

class _RunZonedPageState extends State<RunZonedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                int result = runZoned<int>(
                  () {
                    throw Exception("エラーが発生");
                  },
                  onError: (error, stackTrace) {
                    print("エラーをキャッチ: $error");
                  },
                );

                print("結果: $result"); // 実行時エラーになる
              },
              child: Text('tap'))),
    );
  }
}
