import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class RidgeDetection extends Filter {
  const RidgeDetection();

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => applySobel(pointer, image.width, image.height),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
