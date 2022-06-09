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

final _changeBrightness =
    nativeAddLib.lookupFunction<BrightnessFFIFunction, BrightnessDartFunction>(
        'change_brightness');

// Future<Uint8List> changeBrightness(
//   ImageProvider provider,
//   int brightness,
// ) {
//   return Process.transformImage(provider,
//       (pointer, length) => _changeBrightness(pointer, brightness, length));
// }

typedef SimpleTransformationFFIFunc = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length);

typedef SimpleTransformationDartFunc = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length);

final _toGrayscale = nativeAddLib.lookupFunction<SimpleTransformationFFIFunc,
    SimpleTransformationDartFunc>('to_grayscale');

// Future<Uint8List> toGrayscale(ImageProvider provider) {
//   return Process.transformImage(
//       provider, (pointer, length) => _toGrayscale(pointer, length));
// }

final _invert = nativeAddLib.lookupFunction<SimpleTransformationFFIFunc,
    SimpleTransformationDartFunc>('invert');

// Future<Uint8List> invert(ImageProvider provider) {
//   return Process.transformImage(
//       provider, (pointer, length) => _invert(pointer, length));
// }

typedef ThresholdFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Int16 threshold);

typedef ThresholdDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int threshold);

final _applyThreshold =
    nativeAddLib.lookupFunction<ThresholdFFIFunction, ThresholdDartFunction>(
        'apply_threshold');

// Future<Uint8List> applyThreshold(
//   ImageProvider provider,
//   int threshold,
// ) {
//   return Process.transformImage(provider,
//       (pointer, length) => _applyThreshold(pointer, length, threshold));
// }
