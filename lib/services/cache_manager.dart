import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  final String fileName;
  Directory _tempDir;

  CacheManager(this.fileName) {
    checkCache();
  }

  checkCache() async {
    _tempDir = await getTemporaryDirectory();

    File file = File(_tempDir.path + '/' + fileName);
    var isExists = await file.exists();
    print(isExists);

    String tempPath = _tempDir.path;
    print('getTemporaryDirectory $tempPath');
  }
}