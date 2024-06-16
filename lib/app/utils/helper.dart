import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<int> getAndroidSdkVersion() async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  } else {
    return 0;
  }
}

Directory? findRoot(FileSystemEntity? entity) {
  if (entity == null) return null;
  final Directory parent = entity.parent;
  if (Platform.isAndroid) {
    if (parent.path == '/storage/emulated') return Directory(entity.path);
    return findRoot(parent);
  } else {
    return Directory(entity.path);
  }
}
