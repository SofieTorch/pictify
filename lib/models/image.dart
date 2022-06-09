import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pictify/utils/utils.dart';

class Image {
  final Uint8List _bytes;
  Uint8List content;
  late int length;
  late int width;
  late int height;

  Image._({
    required Uint8List bytes,
    required this.length,
    required this.width,
    required this.height,
    Uint8List? content,
  })  : _bytes = bytes,
        content = content ?? bytes;

  static Future<Image> create(ImageProvider provider) async {
    final image = await Process.providerToImage(provider);
    final bytes = await Process.imageToUInt8List(image);

    final length = bytes.length;

    return Image._(
      bytes: bytes,
      length: length,
      width: image.width,
      height: image.height,
    );
  }

  Uint8List get bytes {
    if (content.length == length + RGBA32Header.headerSize) {
      return content.sublist(RGBA32Header.headerSize);
    }

    return content;
  }

  Image copyWith({
    Uint8List? bytes,
    int? length,
    int? width,
    int? height,
  }) {
    return Image._(
      bytes: bytes ?? _bytes,
      length: length ?? this.length,
      width: width ?? this.width,
      height: height ?? this.height,
      content: bytes ?? content,
    );
  }
}
