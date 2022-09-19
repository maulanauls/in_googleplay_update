import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_googleplay_update/in_googleplay_update_method_channel.dart';

void main() {
  MethodChannelInGoogleplayUpdate platform = MethodChannelInGoogleplayUpdate();
  const MethodChannel channel = MethodChannel('in_googleplay_update');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
