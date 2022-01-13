import 'package:app/cache/cache_keys.dart' as cache_keys;
import 'package:hive/hive.dart';

class NetworkConfigRepository {
  Future<void> setBaseUrl(String ip, String? port) async {
    var baseUrl = "http://$ip:${port ?? "80"}/";
    print(baseUrl);

    var storage = await Hive.openBox(cache_keys.baseUrlBoxName);
    storage.put(cache_keys.baseUrlKey, baseUrl);
    storage.put(cache_keys.baseUrlIp, ip);
    storage.put(cache_keys.baseUrPort, port ?? "80");

    await storage.close();
  }

  Future<String?> getBaseUrl() async {
    var storage = await Hive.openBox(cache_keys.baseUrlBoxName);
    var baseUrl = storage.get(cache_keys.baseUrlKey);
    await storage.close();

    return baseUrl;
  }

  Future<Map<String, String>?> getIpAndPort() async {
    var storage = await Hive.openBox(cache_keys.baseUrlBoxName);
    var ip = storage.get(cache_keys.baseUrlIp);
    var port = storage.get(cache_keys.baseUrPort);

    print(ip);
    print(port);
    await storage.close();

    return {
      "ip": ip,
      "port": port,
    };
  }
}
