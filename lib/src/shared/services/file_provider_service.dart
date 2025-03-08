import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileProviderService {
  static final FileProviderService _fileProviderService =
      FileProviderService._internal();

  factory FileProviderService() {
    return _fileProviderService;
  }

  FileProviderService._internal();

  Future<void> checkForPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted &&
          // access media location needed for android 10/Q
          await Permission.accessMediaLocation.request().isGranted &&
          // manage external storage needed for android 11/R
          await Permission.manageExternalStorage.request().isGranted) {
        await createDirectory(DirectoryType.public, 'expensegenie');
      } else {
        await _requestStoragePermission();
      }
    }
  }

  Future<String> get cachePath async {
    final cache = await getExternalCacheDirectories();
    return cache!.first.path;
  }

  Future<String> get storagePath async {
    final storage = await getExternalStorageDirectory();
    return storage!.path;
  }

  String get publicPath => '/storage/emulated/0';

  Future<dynamic> createDirectory(DirectoryType dirType, String dirName,
      {bool recursive = false}) async {
    String path = await _getDirPath(dirType);
    if (!Directory('$path/$dirName').existsSync()) {
      return await Directory('$path/$dirName').create(recursive: recursive);
    }
  }

  Future<String> getFile(DirectoryType dirType, String filePath) async {
    String path = await _getDirPath(dirType);
    return await File(path + filePath).readAsString();
  }

  Future<File> writeFile(
      DirectoryType dirType, String filePath, String content) async {
    String path = await _getDirPath(dirType);
    return await File(path + filePath).writeAsString(content);
  }

  Future<String> _getDirPath(DirectoryType dirType) async {
    String path = publicPath;
    switch (dirType) {
      case DirectoryType.cache:
        path = await cachePath;
        break;
      case DirectoryType.public:
        path = publicPath;
        break;
      case DirectoryType.storage:
        path = await storagePath;
        break;
    }

    return path;
  }

  Future<void> _requestStoragePermission() async {
    await Permission.storage.request();
    await Permission.accessMediaLocation.request();
    await Permission.manageExternalStorage.request();
  }
}

enum DirectoryType { cache, storage, public }
