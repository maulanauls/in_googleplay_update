import 'package:flutter_test/flutter_test.dart';
import 'package:in_googleplay_update/in_googleplay_update.dart';
import 'package:in_googleplay_update/in_googleplay_update_platform_interface.dart';
import 'package:in_googleplay_update/in_googleplay_update_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInGoogleplayUpdatePlatform
    with MockPlatformInterfaceMixin
    implements InGoogleplayUpdatePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InGoogleplayUpdatePlatform initialPlatform = InGoogleplayUpdatePlatform.instance;

  test('$MethodChannelInGoogleplayUpdate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInGoogleplayUpdate>());
  });

  test('getPlatformVersion', () async {
    InAppPlayUpdate inGoogleplayUpdatePlugin = InAppPlayUpdate();
    MockInGoogleplayUpdatePlatform fakePlatform = MockInGoogleplayUpdatePlatform();
    InGoogleplayUpdatePlatform.instance = fakePlatform;

    expect(await InAppPlayUpdate.startFlexibleUpdate(), '42');
  });
}
