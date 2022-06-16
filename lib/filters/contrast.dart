import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class GrayContrast extends Filter {
  GrayContrast({
    required this.contrast,
  });

  final int contrast;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => changeGrayContrast(pointer, length, contrast),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
