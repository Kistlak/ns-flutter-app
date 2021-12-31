import 'package:http/http.dart' as http;

class HttpClient{
  http.Client secClient = new http.Client();
  String token = '';
  int expireIn = 0;
  int id = 0;

  static String baseURL = 'https://ion-groups.live';
  static String healthBaseURL = 'http://139.59.111.170';

  var headers;

  HttpClient();

  void changeToken(String newToken){
    this.token = newToken;
    this.headers = {
      'Authorization': 'Bearer $newToken',
      'Content-Type': 'application/json'

    };
  }
  void changeExpireIn(int seconds){
    this.expireIn = seconds;
  }
  void changeID(int newID){
    this.id = newID;
  }

  String getToken(){
    return this.token;
  }

  getHeader(){
    return this.headers;
  }
}

HttpClient client = new HttpClient();
