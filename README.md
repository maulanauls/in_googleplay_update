<!-- [![pub package](https://img.shields.io/pub/v/in_app_update.svg)](https://pub.dev/packages/in_app_update) -->

Presented by

<!-- <img src="https://ffuf.de/assets/img/shared/ffuf-logo-red.svg" width="150"> -->

https://lapakprogrammer.com/

Maintained by [ACHMAD MAULANA](https://lapakprogrammer.com/developer/achmad-maulana)

# in_app_update

Enables In App Updates on Android using the official Android APIs.

https://developer.android.com/guide/app-bundle/in-app-updates

<img src="https://2.bp.blogspot.com/-9V4ZsdRRnIA/XNSYN-do_OI/AAAAAAAAI90/2yFBsTij0kcibkGRuB79fS_jZKcy-APdQCLcBGAs/s1600/Screen%2BShot%2B2019-05-09%2Bat%2B2.13.58%2BPM.png" width="400">

## Documentation

The following methods are exposed:
- `Future<AppUpdateInfo> checkForUpdate()`: Checks if there's an update available
- `Future<void> performImmediateUpdate()`: Performs an immediate update (full-screen)
- `Future<void> startFlexibleUpdate()`: Starts a flexible update (background download)
- `Future<void> completeFlexibleUpdate()`: Actually installs an available flexible update

Please have a look in the example app on how to use it!

### Android

This plugin integrates the official Android APIs to perform in app updated that were released in 2019:
https://developer.android.com/guide/app-bundle/in-app-updates

# Troubleshooting

## Getting ERROR_API_NOT_AVAILABLE error
Be aware that this plugin cannot be tested locally. It must be installed via Google Play to work. 
Please check the official documentation about In App Updates from Google.