import 'dart:async';

import 'package:flutter/material.dart';

class ZonePage extends StatefulWidget {
  const ZonePage({super.key, required this.title});
  final String title;

  @override
  State<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
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
                runZonedGuarded(() {
                  // ゾーンAで Future を作成
                  final future = Future.error(Exception('ゾーンAで発生したエラー'));
                  runZonedGuarded(() {
                    // ゾーンBでゾーンAの Future を利用
                    future.catchError((error) {
                      print('ゾーンBでエラーをキャッチ: $error');
                    });
                  }, (error, stack) {
                    print('ゾーンBで未処理のエラーをキャッチ: $error');
                  });
                }, (error, stack) {
                  print('ゾーンAで未処理のエラーをキャッチ: $error');
                });
              },
              child: Text('tap'))),
    );
  }
}
