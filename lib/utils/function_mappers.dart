import 'dart:ffi';

typedef SimpleTransformationFFIFunc = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length);

typedef SimpleTransformationDartFunc = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length);

typedef BrightnessFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Int16 brightness);

typedef BrightnessDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int brightness);

typedef ThresholdFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Int16 threshold);

typedef ThresholdDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int threshold);

typedef FilterColorFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Pointer<Uint8> filters);

typedef FilterColorDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, Pointer<Uint8> filters);

typedef SobelFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 width, Uint32 height);

typedef SobelDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int width, int height);

typedef HueFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Double hue);

typedef HueDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, double hue);

typedef ToneFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Int16 tone);

typedef ToneDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int tone);

typedef SolarizeFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Uint8 levels);

typedef SolarizeDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int levels);

typedef GrayContrastFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Int16 contrast);

typedef GrayContrastDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, int contrast);

typedef ChangeColorFFIFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, Uint32 length, Pointer<Int16> colors);

typedef ChangeColorDartFunction = Pointer<Uint8> Function(
    Pointer<Uint8> bitmap, int length, Pointer<Int16> colors);
