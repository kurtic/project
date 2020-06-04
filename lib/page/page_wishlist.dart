import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stream_games/controller/scroll_horizontal_game.dart';
import 'package:stream_games/model/game.dart';
import 'package:stream_games/utils/APIget.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: FirebaseAuth.instance.currentUser().asStream(),
              builder: (context, currentUser) {
                String user;
                if (currentUser.data == null)
                  return CircularProgressIndicator();
                else
                  user = currentUser.data.email;
                return StreamBuilder(
                    stream: Firestore.instance
                        .collection('Wishlist' + user)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          snapshot.data.documents == null)
                        return CircularProgressIndicator();
                      else
                        return GridView.builder(
                            primary: false,
                            itemCount: snapshot.data.documents.length,
                            gridDelegate:
                                new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return new Card(
                                child: Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2.5,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot.data.documents[
                                                                    index]
                                                                ['cover'] ==
                                                            null
                                                        ? CircularProgressIndicator()
                                                        : snapshot
                                                                .data.documents[
                                                            index]['cover'],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        alignment:
                                            FractionalOffset.bottomCenter,
                                        child: Text(
                                          snapshot.data.documents[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Remove",
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          ),
                                          onPressed: () async {
                                            await Firestore.instance
                                                .runTransaction((Transaction
                                                    myTransaction) async {
                                              await myTransaction.delete(
                                                  snapshot.data.documents[index]
                                                      .reference);
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                    });
              })
        ],
      ),
    );
  }
}
