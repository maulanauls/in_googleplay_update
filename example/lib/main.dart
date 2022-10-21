import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:in_googleplay_update/in_googleplay_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:filesize/filesize.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }
  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }
  AppPlayUpdateInfo? _updateInfo;
  AppUpdateResult? _updateResult;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppPlayUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('In App Update Example App'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _infoTile('update availability', '${_updateInfo?.updateAvailability}'),
                    _infoTile('immediate update allowed', '${_updateInfo?.immediateUpdateAllowed}'),
                    _infoTile('available version code', '${_updateInfo?.availableVersionCode}'),
                    _infoTile('install status', '${_updateInfo?.installStatus}'),
                    _infoTile('package name', '${_updateInfo?.packageName}'),
                    _infoTile('client version stanleness days', '${_updateInfo?.clientVersionStalenessDays}'),
                    _infoTile('update priority', '${_updateInfo?.updatePriority}'),
                    _infoTile('update result', '${_updateResult}'),
                  ],
                ),
                ElevatedButton(
                  child: const Text('Check for update'),
                  onPressed: () => checkForUpdate(),
                ),
                ElevatedButton(
                  child: Text('Perform immediate update'),
                  onPressed: _updateInfo?.updateAvailability ==
                      UpdateAvailability.updateAvailable
                      ? () {
                    InAppPlayUpdate.performImmediateUpdate()
                        .catchError((e) => showSnack(e.toString()));
                  }
                      : null,
                ),
                ElevatedButton(
                  child: Text('Start flexible update'),
                  onPressed: _updateInfo?.updateAvailability ==
                      UpdateAvailability.updateAvailable
                      ? () {
                    InAppPlayUpdate.startFlexibleUpdate().then((_) {
                      setState(() {
                        _updateResult = _;
                        _flexibleUpdateAvailable = true;
                      });
                    }).catchError((e) {
                      showSnack(e.toString());
                    });
                  }
                      : null,
                ),
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
                      // return Text(
                      //   '${filesize(int.parse(byteDownload['bytes_downloaded']))}',
                      //   style: TextStyle(
                      //     fontSize: 10
                      //   ),
                      // );
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
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _infoTile('App name', _packageInfo.appName),
                    _infoTile('Package name', _packageInfo.packageName),
                    _infoTile('App version', _packageInfo.version),
                    _infoTile('Build number', _packageInfo.buildNumber),
                    _infoTile('Build signature', _packageInfo.buildSignature),
                    _infoTile(
                      'Installer store',
                      _packageInfo.installerStore ?? 'not available',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}