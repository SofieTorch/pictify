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
          Image.asset('assets/snoopy.png'),
          FutureBuilder(
            future: pic.Image.create(const AssetImage('assets/snoopy.png')),
            builder: (_, AsyncSnapshot<pic.Image> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              image = snapshot.data!;
              final grayImage = const pic.Grayscale().apply(image);

              return Column(
                children: [
                  ContrastChangedImage(grayImage),

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
                  ChannelFilteredImage(image),
                  ColorFilteredImage(image),
                  ColorChangedImage(image),
                  // ToneChangedImage(image),
                  // HueChangedImage(image),
                  Image.memory(
                    const pic.Grayscale().apply(image).content,
                    gaplessPlayback: true,
                  ),
                  Image.memory(
                    const pic.Invert().apply(image).content,
                    gaplessPlayback: true,
                  ),
                  // Image.memory(
                  //   const pic.RidgeDetection().apply(grayImage).content,
                  // ),
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

class ChannelFilteredImage extends StatefulWidget {
  const ChannelFilteredImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ChannelFilteredImage> createState() => _ChannelFilteredImageState();
}

class _ChannelFilteredImageState extends State<ChannelFilteredImage> {
  RangeValues redValues = const RangeValues(70, 160);
  RangeValues greenValues = const RangeValues(70, 160);
  RangeValues blueValues = const RangeValues(70, 160);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.ChannelFilter(
            filters: [
              redValues.start.round(),
              redValues.end.round(),
              greenValues.start.round(),
              greenValues.end.round(),
              blueValues.start.round(),
              blueValues.end.round(),
            ],
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.red,
          values: redValues,
          onChanged: (values) {
            setState(() {
              redValues = values;
            });
          },
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.green,
          values: greenValues,
          onChanged: (values) {
            setState(() {
              greenValues = values;
            });
          },
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.blue,
          values: blueValues,
          onChanged: (values) {
            setState(() {
              blueValues = values;
            });
          },
        ),
      ],
    );
  }
}

class ColorFilteredImage extends StatefulWidget {
  const ColorFilteredImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ColorFilteredImage> createState() => _ColorFilteredImageState();
}

class _ColorFilteredImageState extends State<ColorFilteredImage> {
  RangeValues redValues = const RangeValues(70, 160);
  RangeValues greenValues = const RangeValues(70, 160);
  RangeValues blueValues = const RangeValues(70, 160);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.ColorFilter(
            filters: [
              redValues.start.round(),
              redValues.end.round(),
              greenValues.start.round(),
              greenValues.end.round(),
              blueValues.start.round(),
              blueValues.end.round(),
            ],
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.red,
          values: redValues,
          onChanged: (values) {
            setState(() {
              redValues = values;
            });
          },
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.green,
          values: greenValues,
          onChanged: (values) {
            setState(() {
              greenValues = values;
            });
          },
        ),
        RangeSlider(
          min: 0,
          max: 255,
          activeColor: Colors.blue,
          values: blueValues,
          onChanged: (values) {
            setState(() {
              blueValues = values;
            });
          },
        ),
      ],
    );
  }
}

class ColorChangedImage extends StatefulWidget {
  const ColorChangedImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ColorChangedImage> createState() => _ColorChangedImageState();
}

class _ColorChangedImageState extends State<ColorChangedImage> {
  double redValue = 0;
  double greenValue = 0;
  double blueValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.ColorChange(
            red: redValue.round(),
            green: greenValue.round(),
            blue: blueValue.round(),
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        Slider(
          min: -128,
          max: 128,
          activeColor: Colors.red,
          value: redValue,
          onChanged: (value) {
            setState(() {
              redValue = value;
            });
          },
        ),
        Slider(
          min: -128,
          max: 128,
          activeColor: Colors.green,
          value: greenValue,
          onChanged: (value) {
            setState(() {
              greenValue = value;
            });
          },
        ),
        Slider(
          min: -128,
          max: 128,
          activeColor: Colors.blue,
          value: blueValue,
          onChanged: (value) {
            setState(() {
              blueValue = value;
            });
          },
        ),
      ],
    );
  }
}

class HueChangedImage extends StatefulWidget {
  const HueChangedImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<HueChangedImage> createState() => _HueChangedImageState();
}

class _HueChangedImageState extends State<HueChangedImage> {
  double _hueValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.Hue(
            hue: _hueValue,
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        Slider(
          min: -128,
          max: 128,
          value: _hueValue,
          onChanged: (value) {
            setState(() {
              _hueValue = value;
            });
          },
        ),
      ],
    );
  }
}

class ToneChangedImage extends StatefulWidget {
  const ToneChangedImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ToneChangedImage> createState() => _ToneChangedImageState();
}

class _ToneChangedImageState extends State<ToneChangedImage> {
  double _toneValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.Tone(
            tone: _toneValue.round(),
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        Slider(
          min: -128,
          max: 128,
          value: _toneValue,
          onChanged: (value) {
            setState(() {
              _toneValue = value;
            });
          },
        ),
      ],
    );
  }
}

class ContrastChangedImage extends StatefulWidget {
  const ContrastChangedImage(this.image, {Key? key}) : super(key: key);

  final pic.Image image;

  @override
  State<ContrastChangedImage> createState() => _ContrastChangedImageState();
}

class _ContrastChangedImageState extends State<ContrastChangedImage> {
  double _contrastValue = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.memory(
          pic.GrayContrast(
            contrast: _contrastValue.round(),
          ).apply(widget.image).content,
          gaplessPlayback: true,
        ),
        Slider(
          min: -128,
          max: 128,
          value: _contrastValue,
          onChanged: (value) {
            setState(() {
              _contrastValue = value;
            });
          },
        ),
      ],
    );
  }
}
