import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart' as ext_ffi;

import 'package:pictify/models/models.dart';

typedef ImageTransform = Pointer<Uint8> Function(
    Pointer<Uint8> pointer, int length);

abstract class Filter {
  const Filter();

  Uint8List convertImage(Image image, ImageTransform transform) {
    final header = RGBA32Header(image.width, image.height);
    final length = image.length;
    final Pointer<Uint8> pointer = ext_ffi.calloc<Uint8>(length);
    pointer.asTypedList(length).setAll(0, image.bytes);

    final pointerResult = transform(pointer, length);
    final result = pointerResult.asTypedList(length);
    header.appendContent(result);

    ext_ffi.calloc.free(pointer);
    return header.headedImage;
  }

  Image apply(Image image);
}
