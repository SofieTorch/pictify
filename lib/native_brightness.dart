import 'dart:ffi';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:pictify/utils/utils.dart';

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

typedef BrightnessFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Int16 brightness, Uint32 length);

typedef BrightnessDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int brightness, int length);

final BrightnessDartFunction _changeBrightness =
    nativeAddLib.lookupFunction<BrightnessFFIFunction, BrightnessDartFunction>(
        'change_brightness');

Future<Uint8List> changeBrightness(
  ImageProvider provider,
  int brightness,
) {
  return Process.transformImage(provider,
      (pointer, length) => _changeBrightness(pointer, brightness, length));
}

typedef GrayscaleFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length);

typedef GrayscaleDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length);

final GrayscaleDartFunction _toGrayscale =
    nativeAddLib.lookupFunction<GrayscaleFFIFunction, GrayscaleDartFunction>(
        'to_grayscale');

Future<Uint8List> toGrayscale(ImageProvider provider) {
  return Process.transformImage(
      provider, (pointer, length) => _toGrayscale(pointer, length));
}
