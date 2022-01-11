class Camera {
  Camera({
    required this.cameraName,
    required this.cameraId,
    required this.cameraLocation,
  });

  Camera.fromJson(Map<String, String> cameraJson)
      : cameraName = cameraJson["cameraName"],
        cameraId = cameraJson["cameraId"],
        cameraLocation = cameraJson["cameraLocation"];

  Map<String, String> toJson() {
    return {
      "cameraName": cameraName ?? "",
      "cameraStreamUrl": cameraId ?? "",
      "cameraLocation": cameraLocation ?? "",
    };
  }

  final String? cameraName;
  final String? cameraId;
  final String? cameraLocation;

  String get cameraStreamUrl => "http://localhost:8000/api/cameras/$cameraId";
}
