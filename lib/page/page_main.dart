import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_games/bottom_menu_items.dart';
import 'package:stream_games/icons.dart';
import 'package:stream_games/model/game.dart';
import 'package:stream_games/page/page_basket.dart';
import 'package:stream_games/page/page_browse.dart';
import 'package:stream_games/page/page_coming_soon.dart';
import 'package:stream_games/page/page_games.dart';
import 'package:stream_games/page/page_movies.dart';
import 'package:stream_games/page/page_more.dart';
import 'package:stream_games/page/page_wishlist.dart';
import 'package:stream_games/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

  class _MainPageState extends State<MainPage> {
  BottomMenu _layoutSelection = BottomMenu.games;

  void _goBasketPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return BasketListPage();
        },
      ),
    );
  }
  getBasket() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String _email= user.email;
    return Firestore.instance.collection('Basket'+_email).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.hardEdge,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                menuItemName(_layoutSelection),
                style: Theme.of(context).textTheme.title,
              ),
              Padding(padding: EdgeInsets.only(right: 8)),
              Icon(menuIcon(_layoutSelection), size: 28, color: Colors.black),
            ],
          ),
          actions: <Widget>[

            Center(
              child: IconButton(
                  onPressed: ()  => {
                      _goBasketPage(context)
                  },
                  icon: Stack(
                    children: <Widget>[

                      Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.shopping_cart,
                            size: 28, color: Colors.black),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.green,
                          child:

                          StreamBuilder(
                            stream:  FirebaseAuth.instance.currentUser().asStream(),
                            builder: (context,currentUser){
                              String user;
                              if(currentUser.data==null)
                                return CircularProgressIndicator();
                              else user = currentUser.data.email;
                              return  StreamBuilder(
                                  stream: Firestore.instance.collection('Basket'+user).snapshots(),
                                  builder:(context, snapshot) {
                                    if (snapshot.data == null || snapshot.data.documents ==null)
                                      return CircularProgressIndicator();
                                    else return Text(snapshot.data.documents.length.toString(),
                                        style:TextStyle(color: Colors.white, fontSize: 10));});
                        }),
                        ),
                      ),

                    ],
                  )),
            ),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.blueAccent,
          backgroundColor: Colors.white70,
          items: <BottomNavigationBarItem>[
            _buildMenuItem(
                icon: controllerOutlineIcon,
                iconSelected: controllerIcon,
                bottomMenu: BottomMenu.games),
            _buildMenuItem(
                icon: movieOutlineIcon,
                iconSelected: movieIcon,
                bottomMenu: BottomMenu.movies),
            _buildMenuItem(
                icon: browseOutlineIcon,
                iconSelected: browseIcon,
                bottomMenu: BottomMenu.browse),
            _buildMenuItem(
                icon: profileOutlineIcon,
                iconSelected: profileIcon,
                bottomMenu: BottomMenu.my),
            _buildMenuItem(
                icon: moreOutlineIcon,
                iconSelected: moreIcon,
                bottomMenu: BottomMenu.more),
          ],
          onTap: _onSelectMenuItem,
        ),
        body: _buildPage(),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildPage() {
    switch (_layoutSelection) {
      case BottomMenu.games:
        return GamesPage();
      case BottomMenu.movies:
        return ComingSoonPage(menuIcon(_layoutSelection));
      case BottomMenu.browse:
        return BrowsePage();
      case BottomMenu.my:
        return WishListPage();
      case BottomMenu.more:
        return  MorePage();/*FlatButton.icon(
            onPressed: (){
              AuthService().logOut();
            },
            icon:Icon(Icons.exit_to_app,color:Colors.green),
            label:SizedBox.shrink());*/
    }
    return null;
  }

  BottomNavigationBarItem _buildMenuItem(
      {IconData icon, IconData iconSelected, BottomMenu bottomMenu}) {
    String text = menuItemName(bottomMenu);
    IconData setIcon = _setIconSelected(
        bottomMenu: bottomMenu, icon: icon, iconSelected: iconSelected);
    return BottomNavigationBarItem(
      icon: Icon(
        setIcon,
        color: _setMenuItemColor(bottomMenu: bottomMenu),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _setMenuItemColor(bottomMenu: bottomMenu),
        ),
      ),
    );
  }

  IconData _setIconSelected(
      {BottomMenu bottomMenu, IconData icon, IconData iconSelected}) {
    return _layoutSelection == bottomMenu ? iconSelected : icon;
  }

  Color _setMenuItemColor({BottomMenu bottomMenu}) {
    return _layoutSelection == bottomMenu ? Colors.blueAccent : Colors.grey;
  }

  void _onSelectMenuItem(int index) {
    switch (index) {
      case 0:
        _onLayoutSelected(BottomMenu.games);
        break;
      case 1:
        _onLayoutSelected(BottomMenu.movies);
        break;
      case 2:
        _onLayoutSelected(BottomMenu.browse);
        break;
      case 3:
        _onLayoutSelected(BottomMenu.my);
        break;
      case 4:
        _onLayoutSelected(BottomMenu.more);
        break;
    }
  }

  void _onLayoutSelected(BottomMenu selection) {
    setState(() {
      _layoutSelection = selection;
    });
  }

}
