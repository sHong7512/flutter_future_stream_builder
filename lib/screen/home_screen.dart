import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFuture = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isFuture
                ? _FutureBuilder(onPressed: startSetState, textStyle: textStyle)
                : _StreamBuilder(onPressed: startSetState, textStyle: textStyle),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isFuture = !isFuture;
                });
              },
              child: Text('Change Mode'),
            ),
          ],
        ),
      ),
    );
  }

  startSetState() {
    setState(() {});
  }
}

class _FutureBuilder extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const _FutureBuilder({
    Key? key,
    required this.onPressed,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: getFutureNumber(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // 데이터가 있을떄 랜더링
        }

        if (snapshot.hasError) {
          // 에러가 났을 떄 위젯 렌더링
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'FutureBuilder',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            Text(
              'ConState : ${snapshot.connectionState}',
              style: textStyle,
            ),
            Text(
              'Data : ${snapshot.data}',
              style: textStyle,
            ),
            Text(
              'Error: ${snapshot.error}',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('setState'),
            ),
          ],
        );
      },
    );
  }

  Future<int> getFutureNumber() async {
    await Future.delayed(Duration(milliseconds: 500));

    final random = Random().nextInt(10);

    print('$random');
    if (random == 5) {
      throw Exception('(rand = 5)이 발생했습니다.');
    } else {
      return random;
    }
  }
}

class _StreamBuilder extends StatelessWidget {
  final VoidCallback onPressed;
  final TextStyle textStyle;

  const _StreamBuilder({
    Key? key,
    required this.onPressed,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: streamNumbers(),
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'StreamBuilder',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
              ),
            ),
            Text(
              'ConState : ${snapshot.connectionState}',
              style: textStyle,
            ),
            Text(
              'Data : ${snapshot.data}',
              style: textStyle,
            ),
            Text(
              'Error: ${snapshot.error}',
              style: textStyle,
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text('setState'),
            ),
          ],
        );
      },
    );
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(milliseconds: 500));

      if (i == 5) {
        throw Exception('(rand = 5)이 발생했습니다.');
      }

      yield i;
    }
  }
}
