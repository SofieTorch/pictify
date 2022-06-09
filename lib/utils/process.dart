import 'dart:async';
import 'dart:ffi';
import 'package:ffi/ffi.dart' as ext_ffi;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:pictify/models/filter.dart';
import 'package:pictify/utils/utils.dart';

class Process {
  static Future<ui.Image> providerToImage(ImageProvider provider) async {
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

    stream.removeListener(listener);
    return image;
  }

  static Future<Uint8List> imageToUInt8List(ui.Image image) async {
    final ByteData? byteData = await image.toByteData();
    if (byteData == null) {
      throw StateError("Couldn't serialize image into bytes");
    }

    return byteData.buffer.asUint8List();
  }

  // static Future<Uint8List> transformImage(
  //     ImageProvider provider, ImageTransform transform) async {
  //   final image = await Process.providerToImage(provider);
  //   final bitmap = await Process.imageToUInt8List(image);
  //   final header = RGBA32Header(image.width, image.height);

  //   final length = bitmap.length;
  //   final Pointer<Uint8> pointer = ext_ffi.calloc<Uint8>(length);
  //   pointer.asTypedList(length).setAll(0, bitmap);

  //   final res = transform(pointer, length);
  //   final result = res.asTypedList(length);

  //   header.appendContent(result);
  //   ext_ffi.calloc.free(pointer);

  //   return header.headerBytes;
  // }
}
