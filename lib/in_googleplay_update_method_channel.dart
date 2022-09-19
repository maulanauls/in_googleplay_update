import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_googleplay_update_platform_interface.dart';

/// An implementation of [InGoogleplayUpdatePlatform] that uses method channels.
class MethodChannelInGoogleplayUpdate extends InGoogleplayUpdatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('in_googleplay_update');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
