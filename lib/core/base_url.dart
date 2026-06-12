import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseUrl {
  BaseUrl._internal();
  static final BaseUrl _instance = BaseUrl._internal();
  factory BaseUrl() => _instance;

  static final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");
  static final String kelompok2Url = dotenv.get("KELOMPOK_2_BASE_URL");
}
