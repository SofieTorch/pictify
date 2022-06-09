import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

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
}
