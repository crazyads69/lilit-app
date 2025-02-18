import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class DeviceIdGenerator {
  static const String _deviceIdKey = 'DEVICE_ID';
  final FlutterSecureStorage _secureStorage;
  final DeviceInfoPlugin _deviceInfo;

  // Inject FlutterSecureStorage and DeviceInfoPlugin through constructor
  DeviceIdGenerator(this._secureStorage, this._deviceInfo);

  Future<String> generateDeviceId() async {
    // Check if a device ID already exists in secure storage
    String? storedDeviceId = await _secureStorage.read(key: _deviceIdKey);

    if (storedDeviceId != null) {
      return storedDeviceId;
    }

    // Generate a new device ID
    String newDeviceId = await _createUniqueDeviceId();

    // Store the new device ID in secure storage
    await _secureStorage.write(key: _deviceIdKey, value: newDeviceId);

    return newDeviceId;
  }

  Future<String> _createUniqueDeviceId() async {
    Map<String, dynamic> deviceData = await _getDeviceInfo();

    // Combine characteristics into a single string
    String deviceInfo = deviceData.entries
        .map((entry) => '${entry.key}:${entry.value}')
        .join('|');

    // Use SHA-256 hashing
    return _sha256(deviceInfo);
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return {
        'model': androidInfo.model,
        'brand': androidInfo.brand,
        'androidId': androidInfo.id,
        'board': androidInfo.board,
        'bootloader': androidInfo.bootloader,
        'device': androidInfo.device,
        'display': androidInfo.display,
        'fingerprint': androidInfo.fingerprint,
        'hardware': androidInfo.hardware,
        'host': androidInfo.host,
        'id': androidInfo.id,
        'manufacturer': androidInfo.manufacturer,
        'product': androidInfo.product,
        'type': androidInfo.type,
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return {
        'name': iosInfo.name,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
        'model': iosInfo.model,
        'localizedModel': iosInfo.localizedModel,
        'identifierForVendor': iosInfo.identifierForVendor,
        'isPhysicalDevice': iosInfo.isPhysicalDevice,
        'utsname.sysname:': iosInfo.utsname.sysname,
        'utsname.nodename:': iosInfo.utsname.nodename,
        'utsname.release:': iosInfo.utsname.release,
        'utsname.version:': iosInfo.utsname.version,
        'utsname.machine:': iosInfo.utsname.machine,
      };
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String _sha256(String input) {
    List<int> bytes = utf8.encode(input);
    Digest digest = sha256.convert(bytes);
    return digest.toString().substring(0, 16);
  }
}
