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
  item1.screenshots = screenshots;
  if(newlist["clip"] != null)item1.trailer = newlist["clip"]["clip"].toString();
  else item1.trailer = "notrailer";
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

Future<List<Game>> getData(String url) async {
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
  var item2 = new Game();
  var item3 = new Game();
  var item4 = new Game();
  var item5 = new Game();
  var item6 = new Game();
  var item7 = new Game();
  var item8 = new Game();
  var item9 = new Game();
  var item10 = new Game();
  var item11 = new Game();
  var item12 = new Game();
  var item13 = new Game();
  var item14 = new Game();
  var item15 = new Game();
  var item16 = new Game();
  var item17 = new Game();
  var item18 = new Game();
  var item19 = new Game();
  var item20 = new Game();
  setGameItem(item1, listt, 0);
  setGameItem(item2, listt, 1);
  setGameItem(item3, listt, 2);
  setGameItem(item4, listt, 3);
  setGameItem(item5, listt, 4);
  setGameItem(item6, listt, 5);
  setGameItem(item7, listt, 6);
  setGameItem(item8, listt, 7);
  setGameItem(item9, listt, 8);
  setGameItem(item10, listt, 9);
  setGameItem(item11, listt, 10);
  setGameItem(item12, listt, 11);
  setGameItem(item13, listt, 12);
  setGameItem(item14, listt, 13);
  setGameItem(item15, listt, 14);
  setGameItem(item16, listt, 15);
  setGameItem(item17, listt, 16);
  setGameItem(item18, listt, 17);
  setGameItem(item19, listt, 18);
  setGameItem(item20, listt, 19);
  List<Game> Items = new List<Game>();
  Items.add(item1);
  Items.add(item2);
  Items.add(item3);
  Items.add(item4);
  Items.add(item5);
  Items.add(item6);
  Items.add(item7);
  Items.add(item8);
  Items.add(item9);
  Items.add(item10);
  Items.add(item11);
  Items.add(item12);
  Items.add(item13);
  Items.add(item14);
  Items.add(item15);
  Items.add(item16);
  Items.add(item17);
  Items.add(item18);
  Items.add(item19);
  Items.add(item20);

  return Items;

}