import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pictify/native_brightness.dart';
import 'package:pictify/pictify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Pictify.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Image.asset('assets/image-1080p.jpeg'),
          FutureBuilder(
            future: toGrayscale(const AssetImage('assets/image-1080p.jpeg')),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.hasData) {
                Uint8List bitmap = snapshot.data!;
                return FutureBuilder(
                  future: applyThreshold(MemoryImage(bitmap), 150),
                  builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.hasData) {
                      Uint8List bitmap = snapshot.data!;
                      Image imageRes = Image.memory(bitmap);
                      return imageRes;
                    }
                    return const CircularProgressIndicator();
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder(
            future: changeBrightness(
                const AssetImage('assets/image-1080p.jpeg'), 127),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.hasData) {
                Uint8List bitmap = snapshot.data!;
                Image imageRes = Image.memory(bitmap);
                return imageRes;
              }
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder(
            future: toGrayscale(const AssetImage('assets/image-1080p.jpeg')),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.hasData) {
                Uint8List bitmap = snapshot.data!;
                Image imageRes = Image.memory(bitmap);
                return imageRes;
              }
              return const CircularProgressIndicator();
            },
          ),
          FutureBuilder(
            future: invert(const AssetImage('assets/image-1080p.jpeg')),
            builder: (_, AsyncSnapshot<Uint8List> snapshot) {
              if (snapshot.hasData) {
                Uint8List bitmap = snapshot.data!;
                Image imageRes = Image.memory(bitmap);
                return imageRes;
              }
              return const CircularProgressIndicator();
            },
          ),
        ])),
      ),
    );
  }
}
