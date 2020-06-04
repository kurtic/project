import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_games/component/item_description.dart';
import 'package:stream_games/component/item_header_game.dart';
import 'package:stream_games/controller/scroll_horizontal_screenshots.dart';
import 'package:stream_games/model/game.dart';

class GameDetailsPage extends StatefulWidget {
  GameDetailsPage(this.game, {Key key}) : super(key: key);

  final Game game;



  @override
  _GameDetailsPageState createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
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



  Future addOrUpdateBasket(Game game) async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String _email= user.email;
    Game meth = new Game();
    final CollectionReference _basketCollection = Firestore.instance.collection('Basket'+_email);

    return await _basketCollection.document(game.name).setData(meth.toMap(game));
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GameDetailHeader(widget.game),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: OutlineButton(
                  onPressed: () => {
                    addOrUpdateBasket(widget.game)

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.archive,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        widget.game.price.toString() + '\$',
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .apply(color: Colors.green),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.all(12),
                  borderSide: BorderSide(color: Colors.green, width: 4),
                  color: Colors.white,
                  highlightColor: Colors.white70,
                  splashColor: Colors.green.shade200,
                  highlightElevation: 0,
                  highlightedBorderColor: Colors.green.shade400,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: DescriptionText(widget.game.description)),
            HorizontalScreenshotController(widget.game.screenshots),
          ],
        ),
      ),
    );
  }
}
