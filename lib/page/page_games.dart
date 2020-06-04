import 'package:flutter/material.dart';
import 'package:stream_games/controller/scroll_horizontal_game.dart';
import 'package:stream_games/model/game.dart';
import 'package:stream_games/utils/APIget.dart';
String url2019 =
    "https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added";
String url2020 = 'https://api.rawg.io/api/games?dates=2020-01-01,2021-01-01&ordering=-added';
class GamesPage extends StatefulWidget {
  GamesPage({Key key}) : super(key: key);

  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 8, 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best of 2019",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                    ),
                  ),
                ]),
          ),
          FutureBuilder<List<Game>>(
              future: getData(url2019),
              builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot){
                if (snapshot.hasError) {
                  return Text(
                    'There was an error :(',
                    style: Theme.of(context).textTheme.headline,
                  );
                }
                else if(snapshot.hasData) return HorizontalGameController(snapshot.data);
                else  return  Padding(
                    padding: EdgeInsets.only(left:180,top:30),
                    child: CircularProgressIndicator(),
                  );

              }
          )
          ,
          Divider(height: 2, indent: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most anticipated upcoming games",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  InkWell(
                    onTap: () => {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),

                    ),
                  ),
                ]),
          ),
          new FutureBuilder<List<Game>>(
              future: getData(url2020),
              builder: (BuildContext context, AsyncSnapshot<List<Game>> snapshot){
                if (snapshot.hasError) {
                  return Text(
                    'There was an error :(',
                    style: Theme.of(context).textTheme.headline,
                  );
                }
                else if(snapshot.hasData) return HorizontalGameController(snapshot.data);
                else  return
                    Padding(
                      padding: EdgeInsets.only(left:180,top:100),
                      child: CircularProgressIndicator(),
                    );
              }
          )
        ],
      ),
    );
  }

}