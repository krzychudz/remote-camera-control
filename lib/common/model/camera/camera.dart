class Camera {
  Camera({
    required this.cameraName,
    required this.cameraStreamUrl,
    required this.cameraLocation,
  });

  Camera.fromJson(Map<String, String> cameraJson)
      : cameraName = cameraJson["cameraName"],
        cameraStreamUrl = cameraJson["cameraStreamUrl"],
        cameraLocation = cameraJson["cameraLocation"];

  final String? cameraName;
  final String? cameraStreamUrl;
  final String? cameraLocation;
}