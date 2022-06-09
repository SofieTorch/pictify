import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Threshold extends Filter {
  Threshold({
    required this.threshold,
  });

  final int threshold;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => applyThreshold(pointer, length, threshold),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
