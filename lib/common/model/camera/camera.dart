import 'package:hive/hive.dart';
import 'package:app/cache/cache_keys.dart' as CacheKeys;

class Camera {
  Camera({
    required this.cameraName,
    required this.cameraId,
    required this.cameraLocation,
  });

  Camera.fromJson(Map<String, dynamic> cameraJson)
      : cameraName = cameraJson["title"],
        cameraId = cameraJson["id"],
        cameraLocation = cameraJson["description"];

  Map<String, String> toJson() {
    return {
      "title": cameraName ?? "",
      "id": cameraId ?? "",
      "description": cameraLocation ?? "",
    };
  }

  final String? cameraName;
  final String? cameraId;
  final String? cameraLocation;

  Future<String> get cameraStreamUrl async {
    var storage = await Hive.openBox(CacheKeys.baseUrlBoxName);
    String? baseUrl = storage.get(CacheKeys.baseUrlKey);
    return "${baseUrl}api/cameras/$cameraId";
  }
}
