import 'package:flutter/material.dart';
import 'package:stream_games/component/item_game_container.dart';
import 'package:stream_games/model/game.dart';

class VerticalGameController extends StatelessWidget {
  VerticalGameController(this.gameItems);
  final List<Game> gameItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: ListView.builder(
          itemCount: gameItems == null ? 0 : gameItems.length,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 12, top: 4),
          itemBuilder: (BuildContext context, int position) {
            return GameContainerItem(context, gameItems[position]);
          }),
    );
  }
}
