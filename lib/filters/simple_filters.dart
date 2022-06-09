import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Invert extends Filter {
  const Invert();

  @override
  Image apply(Image image) {
    final result = convertImage(image, invert);
    return image.copyWith(
      bytes: result,
    );
  }
}

class Grayscale extends Filter {
  const Grayscale();

  @override
  Image apply(Image image) {
    final result = convertImage(image, toGrayscale);
    return image.copyWith(
      bytes: result,
    );
  }
}
