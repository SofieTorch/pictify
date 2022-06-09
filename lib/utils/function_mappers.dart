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
