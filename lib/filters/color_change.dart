import 'dart:ffi';
import 'package:ffi/ffi.dart' as ext_ffi;

import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class ColorChange extends Filter {
  ColorChange({
    required this.red,
    required this.green,
    required this.blue,
  });

  final int red, green, blue;

  @override
  Image apply(Image image) {
    final colors = [red, green, blue];
    final Pointer<Int16> colorsPointer = ext_ffi.calloc<Int16>(6);
    colorsPointer.asTypedList(6).setAll(0, colors);

    final result = convertImage(
      image,
      (pointer, length) => changeColors(pointer, length, colorsPointer),
    );

    ext_ffi.calloc.free(colorsPointer);
    return image.copyWith(
      bytes: result,
    );
  }
}
