import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Solarization extends Filter {
  Solarization({
    required this.levels,
  });

  final int levels;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => solarize(pointer, length, levels),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
