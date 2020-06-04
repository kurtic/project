import 'package:meta/meta.dart';

class Game {
  Game({
    this.id,
    @required this.name,
    @required this.box,
    this.cover,
    this.description,
    this.platforms,
    this.rating,
    this.screenshots,
    this.price,
    this.trailer
  });
   int id = 0;
   String name = "";
  String box = "";
   String cover = "";
   String description = "";
   List<String> platforms = new List<String>();
   double rating = 0;
   List<String> screenshots = new List<String>();
  int price = 0;
  String trailer = "";
  Game fromMap( Map<String,dynamic> mapGame ){
    Game game;
    game.id = mapGame["id"];
    game.cover = mapGame["cover"];
    game.description = mapGame["description"];
    game.platforms = mapGame["platforms"];
    game.rating = mapGame["rating"];
    game.screenshots = mapGame["screenshots"];
    game.price = mapGame["price"];
    game.trailer = mapGame["trailer"];
    return game;
  }

  Map<String,dynamic> toMap(Game game) {
    Map<String, dynamic> gameMap = {
      "id": game.id,
      "name": game.name,
      "box": game.box,
      "cover": game.cover,
      "description": game.description,
      "platforms": game.platforms,
      "rating": game.rating,
      "screenshots": game.screenshots,
      "price": game.price,
      " trailer": game.trailer
    };
    return gameMap;
  }
  String getPlatforms() {
    String platformText = "";
    if (platforms.length > 1) {
      for (int i = 0; i < platforms.length; i++) {
        if (i == 0) {
          platformText = platforms[0];
        } else {
          platformText = platformText + " | " + platforms[i];
        }
      }
    } else if (platforms.length == 1) {
      platformText = platforms[0];
    }

    return platformText;
  }
}
