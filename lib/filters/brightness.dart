import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Brightness extends Filter {
  Brightness({
    required this.brightness,
  });

  final int brightness;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => changeBrightness(pointer, length, brightness),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
