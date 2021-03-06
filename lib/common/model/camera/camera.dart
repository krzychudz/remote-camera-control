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
}
