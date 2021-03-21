// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class CookieManager {

  static addToCookie(String key, String value) {
    document.cookie = "$key=$value; max-age=2592000; path=/;";
  }

  static String getCookie(String key) {
    String cookies = document.cookie;
    if(cookies.isEmpty){
      return null;
    }
    List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : [];
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }
    return matchVal;
  }
}