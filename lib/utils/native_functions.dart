import 'dart:ffi';
import 'dart:io';

import 'package:pictify/utils/function_mappers.dart';

final DynamicLibrary library = Platform.isAndroid
    ? DynamicLibrary.open('libnative_add.so')
    : DynamicLibrary.process();

final changeBrightness =
    library.lookupFunction<BrightnessFFIFunction, BrightnessDartFunction>(
        'change_brightness');

final toGrayscale = library.lookupFunction<SimpleTransformationFFIFunc,
    SimpleTransformationDartFunc>('to_grayscale');

final invert = library.lookupFunction<SimpleTransformationFFIFunc,
    SimpleTransformationDartFunc>('invert');

final applyThreshold =
    library.lookupFunction<ThresholdFFIFunction, ThresholdDartFunction>(
        'apply_threshold');

final filterChannel =
    library.lookupFunction<FilterColorFFIFunction, FilterColorDartFunction>(
        'filter_channel');

final filterColor =
    library.lookupFunction<FilterColorFFIFunction, FilterColorDartFunction>(
        'filter_color');

final applySobel = library
    .lookupFunction<SobelFFIFunction, SobelDartFunction>('apply_sobel_filter');

final changeHue =
    library.lookupFunction<HueFFIFunction, HueDartFunction>('change_hue');

final changeTone =
    library.lookupFunction<ToneFFIFunction, ToneDartFunction>('change_tone');

final solarize = library
    .lookupFunction<SolarizeFFIFunction, SolarizeDartFunction>('solarize');

final changeGrayContrast =
    library.lookupFunction<GrayContrastFFIFunction, GrayContrastDartFunction>(
        'change_contrast_gray');

final changeColors =
    library.lookupFunction<ChangeColorFFIFunction, ChangeColorDartFunction>(
        'change_color');
