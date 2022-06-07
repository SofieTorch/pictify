import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pictify/pictify.dart';

void main() {
  const MethodChannel channel = MethodChannel('pictify');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Pictify.platformVersion, '42');
  });
}
