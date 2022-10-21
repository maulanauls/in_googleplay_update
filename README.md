<!-- [![pub package](https://img.shields.io/pub/v/in_app_update.svg)](https://pub.dev/packages/in_app_update) -->

Presented by

<!-- <img src="https://ffuf.de/assets/img/shared/ffuf-logo-red.svg" width="150"> -->

https://lapakprogrammer.com/

Maintained by [ACHMAD MAULANA](https://lapakprogrammer.com/developer/achmad-maulana)

# in_googleplay_update

Enables In App Updates on Android using the official Android APIs.

https://developer.android.com/guide/app-bundle/in-app-updates

<img src="https://2.bp.blogspot.com/-9V4ZsdRRnIA/XNSYN-do_OI/AAAAAAAAI90/2yFBsTij0kcibkGRuB79fS_jZKcy-APdQCLcBGAs/s1600/Screen%2BShot%2B2019-05-09%2Bat%2B2.13.58%2BPM.png" width="400">

## Documentation

The following methods are exposed:
- `Future<AppUpdateInfo> checkForUpdate()`: Checks if there's an update available
- `Future<void> performImmediateUpdate()`: Performs an immediate update (full-screen)
- `Future<void> startFlexibleUpdate()`: Starts a flexible update (background download)
- `Future<void> completeFlexibleUpdate()`: Actually installs an available flexible update
- `Stream<String> flexibleUpdateStream()`: To listener flexible update state this return json string `bytes_downloaded: string, total_bytes_to_download` used this for make progress har download 
example: flexible progressbar
```dart
StreamBuilder<String>(
  stream: InAppPlayUpdate.flexibleUpdateStream(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      String byteStringDownload = snapshot.data ?? '{}';
      final byteDownload = json.decode(byteStringDownload);
      return Column(
        children: [
          if(int.parse(byteDownload['bytes_downloaded']) == 0 && int.parse(byteDownload['total_bytes_to_download']) == 0)...[
            ElevatedButton(
              onPressed: () {
                InAppPlayUpdate.completeFlexibleUpdate().then((_) {
                  showSnack("Success!");
                }).catchError((e) {
                  showSnack(e.toString());
                });
              },
              child: const Text('Complete flexible update'),
            ),
          ] else...[
            LinearProgressIndicator(
              value: (int.parse(byteDownload['bytes_downloaded']) / int.parse(byteDownload['total_bytes_to_download'])),
            ),
            Text('${filesize(int.parse(byteDownload['bytes_downloaded']))}/${filesize(int.parse(byteDownload['total_bytes_to_download']))}',
              style: const TextStyle(
                  fontSize: 14
              ),
            )
          ]
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 10),
          SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
          Text('This loading for download flexible indicator',
            style: const TextStyle(
                fontSize: 14
            ),
          )
        ],
      );
    }
  },
)
```

Please have a look in the example app on how to use it!

### Android

This plugin integrates the official Android APIs to perform in app updated that were released in 2019:
https://developer.android.com/guide/app-bundle/in-app-updates

# Troubleshooting

## Getting ERROR_API_NOT_AVAILABLE error
Be aware that this plugin cannot be tested locally. It must be installed via Google Play to work. 
Please check the official documentation about In App Updates from Google.