import 'package:north_star/Plugins/HttpClient.dart';
import 'package:pusher_client/pusher_client.dart';


class Pusher{
  String appKey = '';
  PusherClient? pusher;
  Channel? channel;

  PusherOptions options = PusherOptions(
    host: 'example.com',
    wsPort: 6001,
    encrypted: false,
    auth: PusherAuth(
      'https://example.com/auth',
      headers: {
        'Authorization': 'Bearer '+ client.token,
      },
    ),
  );

  Pusher(){
    pusher = PusherClient(
        this.appKey,
        this.options,
        autoConnect: false
    );
  }


  void connect(){
    pusher!.connect();
  }
  void disconnect(){
    pusher!.disconnect();
  }

  void connectChat(chatID){
    channel = pusher!.subscribe(chatID);
  }

  void disconnectChat(chatID){
    pusher!.unsubscribe(chatID);
  }

}

Pusher pusherClient = new Pusher();
