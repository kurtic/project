import 'package:flutter/material.dart';
import 'package:stream_games/controller/scroll_horizontal_game.dart';
import 'package:stream_games/model/game.dart';
import 'package:stream_games/model/repository.dart';
import 'package:stream_games/page/page_game_details.dart';
import 'package:stream_games/page/page_games.dart';
import 'package:stream_games/utils/APIgetOne.dart';
String gameSearch = "https://api.rawg.io/api/games?search=";

class BrowsePage extends StatefulWidget {
  BrowsePage({Key key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<BrowsePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(children: <Widget>[
            TextField(
            controller: searchController,
            decoration: new InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Input game name',
            )),
          RaisedButton(
            splashColor: Theme.of(context).primaryColor,
            highlightColor: Theme.of(context).primaryColor,
            color: Colors.white,
            child: Text("Search",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20)),
            onPressed: () async{
              if(searchController.text != "")
              {getDataOne(gameSearch + searchController.text).then((result) {
                _goGameDetailsPage(context, result);
              }
              );}

            },
          ),
        ]));
  }

  void _goGameDetailsPage(BuildContext context, Game game) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return GameDetailsPage(game);
        },
      ),
    );
  }
}
