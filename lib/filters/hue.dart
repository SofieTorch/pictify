import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Hue extends Filter {
  Hue({
    required this.hue,
  });

  final double hue;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => changeHue(pointer, length, hue),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
