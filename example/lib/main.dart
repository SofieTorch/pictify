import 'package:flutter/material.dart';
import 'package:pictify/pictify.dart' as pic;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _valueBrightness = 20;

  late pic.Image image;

  @override
  void initState() {
    super.initState();
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
            future:
                pic.Image.create(const AssetImage('assets/image-1080p.jpeg')),
            builder: (_, AsyncSnapshot<pic.Image> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              image = snapshot.data!;
              final grayImage = const pic.Grayscale().apply(image);

              return Column(
                children: [
                  Image.memory(
                    pic.Brightness(
                      brightness: _valueBrightness.round(),
                    ).apply(image).content,
                    cacheHeight: image.height,
                    gaplessPlayback: true,
                  ),
                  Slider(
                    min: -256,
                    max: 255,
                    value: _valueBrightness,
                    onChanged: (value) {
                      setState(() {
                        _valueBrightness = value;
                      });
                    },
                  ),
                  ThresholdedImage(grayImage),
                  Image.memory(
                    const pic.Grayscale().apply(image).content,
                    gaplessPlayback: true,
                  ),
                  Image.memory(
                    const pic.Invert().apply(image).content,
                    gaplessPlayback: true,
                  ),
                ],
              );
            },
          ),
        ])),
      ),
    );
  }
}

class ThresholdedImage extends StatefulWidget {
  const ThresholdedImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ThresholdedImage> createState() => _ThresholdedImageState();
}

class _ThresholdedImageState extends State<ThresholdedImage> {
  double _thresholdValue = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.Threshold(
            threshold: _thresholdValue.round(),
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        Slider(
          min: 0,
          max: 255,
          value: _thresholdValue,
          onChanged: (value) {
            setState(() {
              _thresholdValue = value;
            });
          },
        ),
      ],
    );
  }
}
