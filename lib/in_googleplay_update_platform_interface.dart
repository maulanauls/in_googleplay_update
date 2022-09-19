import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'in_googleplay_update_method_channel.dart';

abstract class InGoogleplayUpdatePlatform extends PlatformInterface {
  /// Constructs a InGoogleplayUpdatePlatform.
  InGoogleplayUpdatePlatform() : super(token: _token);

  static final Object _token = Object();

  static InGoogleplayUpdatePlatform _instance = MethodChannelInGoogleplayUpdate();

  /// The default instance of [InGoogleplayUpdatePlatform] to use.
  ///
  /// Defaults to [MethodChannelInGoogleplayUpdate].
  static InGoogleplayUpdatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InGoogleplayUpdatePlatform] when
  /// they register themselves.
  static set instance(InGoogleplayUpdatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
