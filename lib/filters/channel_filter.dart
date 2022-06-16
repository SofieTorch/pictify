import 'dart:ffi';
import 'package:ffi/ffi.dart' as ext_ffi;

import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class ChannelFilter extends Filter {
  ChannelFilter({
    required this.filters,
  });

  final List<int> filters;

  @override
  Image apply(Image image) {
    final Pointer<Uint8> filtersPointer = ext_ffi.calloc<Uint8>(6);
    filtersPointer.asTypedList(6).setAll(0, filters);

    final result = convertImage(
      image,
      (pointer, length) => filterChannel(pointer, length, filtersPointer),
    );

    ext_ffi.calloc.free(filtersPointer);
    return image.copyWith(
      bytes: result,
    );
  }
}
