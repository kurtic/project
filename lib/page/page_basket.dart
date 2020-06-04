import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BasketListPage extends StatefulWidget {
  BasketListPage({Key key}) : super(key: key);

  @override
  _BasketListPageState createState() => _BasketListPageState();
}

class _BasketListPageState extends State<BasketListPage> {
  int Sum = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Basket',
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Text(
                    'Basket',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Padding(padding: EdgeInsets.only(right: 8)),
                  Icon(Icons.shopping_basket, size: 28, color: Colors.black),
                ],
              ),
            ),
            body: StreamBuilder(
                stream: FirebaseAuth.instance.currentUser().asStream(),
                builder: (context, currentUser) {
                  String user;
                  if (currentUser.data == null)
                    return CircularProgressIndicator();
                  else
                    user = currentUser.data.email;
                  return StreamBuilder(
                      stream: Firestore.instance
                          .collection('Basket' + user)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null ||
                            snapshot.data.documents == null)
                          return CircularProgressIndicator();
                        else {
                          return ListView(children: <Widget>[
                            GridView.builder(
                                primary: false,
                                itemCount: snapshot.data.documents.length,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  Sum +=
                                      snapshot.data.documents[index]['price'];
                                  return new Card(
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                        image: NetworkImage(snapshot
                                                                            .data
                                                                            .documents[
                                                                        index]
                                                                    ['cover'] ==
                                                                null
                                                            ? CircularProgressIndicator()
                                                            : snapshot.data
                                                                    .documents[
                                                                index]['cover']),
                                                        fit: BoxFit.cover),
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
                                              snapshot
                                                  .data.documents[index]['name']
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
                                                Sum = 0;
                                                await Firestore.instance
                                                    .runTransaction((Transaction
                                                        myTransaction) async {
                                                  await myTransaction.delete(
                                                      snapshot
                                                          .data
                                                          .documents[index]
                                                          .reference);
                                                });
                                              },
                                            ),
                                            Text(
                                              '\$' +
                                                  snapshot.data
                                                      .documents[index]['price']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[500]),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                            StreamBuilder(
                                stream: Firestore.instance
                                    .collection('Basket' + user)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.data == null ||
                                      snapshot.data.documents == null)
                                    return CircularProgressIndicator();
                                  else {
                                    String SumPrice;
                                    int counter =
                                        snapshot.data.documents.length;
                                    int SumPriceInt = 0;
                                    for (int i = 0; i < counter; i++) {
                                      SumPriceInt +=
                                          snapshot.data.documents[i]['price'];
                                    }
                                    SumPrice = SumPriceInt.toString();
                                    if (Sum != 0)
                                      return RaisedButton(
                                        splashColor: Colors.blue,
                                        highlightColor:
                                            Theme.of(context).primaryColor,
                                        color: Colors.white,
                                        child: Text(
                                            "Purchase: " + '\$' + SumPrice,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 20)),
                                        onPressed: () {},
                                      );
                                    else
                                      return Container();
                                  }
                                }),
                          ]);
                        }
                      });
                })));
  }
}
