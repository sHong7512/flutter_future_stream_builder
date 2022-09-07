import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final bool isFuture = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 16.0,
    );

    if (isFuture) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<int>(
            future: getNumber(),
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
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('setState'),
                  ),
                ],
              );
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<int>(
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
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text('setState'),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 2));

    final random = Random().nextInt(10);

    print('$random');
    if (random == 5) {
      throw Exception('(rand = 5)이 발생했습니다.');
    } else {
      return random;
    }
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      if(i == 5){
        throw Exception('(rand = 5)이 발생했습니다.');
      }

      yield i;
    }
  }
}
