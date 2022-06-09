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
