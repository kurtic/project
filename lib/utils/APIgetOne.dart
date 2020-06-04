import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import '../model/game.dart';
Future <Game> getGamePage(Game item1, List listt, int i) async {
  var res = await http.get(
      Uri.encodeFull(
          "https://api.rawg.io/api/games/" + listt[i]["id"].toString()),
      headers: {
        "Accept": "application/json"
      }
  );
  Map newlist = json.decode(res.body);
  //description
  item1.description = newlist["description_raw"].toString();
//screenshots
  List<String> screenshots = new List<String>(2);
  screenshots[0] = newlist["background_image"].toString();
  screenshots[1] = newlist["background_image_additional"].toString();
  if(newlist["clip"] != null)item1.trailer = newlist["clip"]["clip"].toString();
  else item1.trailer = "notrailer";
  item1.screenshots = screenshots;
  return item1;
}

Future<Game> setGameItem(Game item1, List listt, int i) {
  //id
  item1.id = listt[i]["id"];
  //price
  var rng = new Random();
  item1.price = rng.nextInt(60);
  item1.rating = num.parse((rng.nextDouble()*5).toStringAsFixed(1));
  //name
  item1.name = listt[i]["name"];
  //platform
  Map mappp;
  List<String> platforms = new List<String>();
  for (int j = 0; j < listt[i]["platforms"].length; j++) {
    mappp = listt[i]["platforms"][j]["platform"];
    platforms.add(mappp["name"].toString());
  }
  item1.platforms = platforms;
  //cover
  item1.cover = listt[i]["background_image"];
  //box
  item1.box = listt[i]["background_image"];
  //connect to a game page
  return getGamePage(item1, listt, i);
}

Future<Game> getDataOne(String GameName) async {
  String url = "https://api.rawg.io/api/games?search=" + GameName;
  var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
  );
  Map mapp;
  List listt;
  mapp = json.decode(response.body);
  listt = mapp["results"];
  var item1 = new Game();

  return setGameItem(item1, listt, 0);


}