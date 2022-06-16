import 'package:pictify/models/models.dart';
import 'package:pictify/utils/native_functions.dart';

class Tone extends Filter {
  Tone({
    required this.tone,
  });

  final int tone;

  @override
  Image apply(Image image) {
    final result = convertImage(
      image,
      (pointer, length) => changeTone(pointer, length, tone),
    );

    return image.copyWith(
      bytes: result,
    );
  }
}
