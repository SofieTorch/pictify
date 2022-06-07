import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui' as ui;

import 'dart:typed_data';
import 'package:ffi/ffi.dart' as ext_ffi;
import 'package:flutter/rendering.dart';
import 'package:pictify/utils/image_header.dart';

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

typedef BrightnessFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint8 brightness, Uint8 length);

typedef BrightnessDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int brightness, int length);

final BrightnessDartFunction _changeBrightness =
    nativeAddLib.lookupFunction<BrightnessFFIFunction, BrightnessDartFunction>(
        'change_brightness');

Future<Uint8List> changeBrightness(
    ImageProvider provider, int brightness) async {
  final image = await getImagefromProvider(provider);
  final bitmap = await getUInt8ListFromImage(image);
  final header = RGBA32Header(image.width, image.height);

  final length = bitmap.length;
  final Pointer<Uint8> pointer = ext_ffi.calloc<Uint8>(length);
  pointer.asTypedList(length).setAll(0, bitmap);

  final res = _changeBrightness(pointer, brightness, length);
  final result = res.asTypedList(length);

  header.appendContent(result);
  ext_ffi.calloc.free(pointer);

  return header.headedImage;
}

Future<ui.Image> getImagefromProvider(ImageProvider provider) async {
  final Completer completer = Completer<ImageInfo>();
  final ImageStream stream = provider.resolve(const ImageConfiguration());
  final listener = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      if (!completer.isCompleted) {
        completer.complete(info);
      }
    },
  );
  stream.addListener(listener);
  final imageInfo = await completer.future;

  final ui.Image image = imageInfo.image;
  return image;
}

Future<Uint8List> getUInt8ListFromImage(ui.Image image) async {
  final ByteData? byteData = await image.toByteData();
  if (byteData == null) {
    throw StateError("Couldn't serialize image into bytes");
  }

  return byteData.buffer.asUint8List();
}
