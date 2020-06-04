import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_games/services/auth.dart';

class MorePage extends StatefulWidget {
  MorePage({Key key}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  TextEditingController _oldPasswordContoller = TextEditingController();
  TextEditingController _newPasswordContoller = TextEditingController();

  Widget _ChangePassword(TextEditingController _oldPasswordController,TextEditingController _newPasswordController){
    return Column(
        children:<Widget>[Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: TextField(
            controller: _oldPasswordController,
            style: TextStyle(fontSize: 20, color:Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white30),
                focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.white,width:3)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.white54,width:1)
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: IconTheme(
                      data: IconThemeData(color: Colors.white),

                  ),
                )
            ),
          ),
        ),]
     );
  }
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 500,
        height: 50.0,
        child: ListView(children: <Widget>[
          RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              highlightColor: Theme.of(context).primaryColor,
              color: Colors.green,
              child: Text("Change Password",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20)),
              onPressed: () async {
                String _email;
                FirebaseUser user = await FirebaseAuth.instance.currentUser();
                _email= user.email;
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.sendPasswordResetEmail(email: _email);
                Fluttertoast.showToast(
                    msg: "Change password letter was sent to "+_email,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }),
          Container(
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                  splashColor: Theme.of(context).primaryColor,
                  highlightColor: Theme.of(context).primaryColor,
                  color: Colors.green,
                  child: Text("Log Out",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                  onPressed: () {
                    AuthService().logOut();
                  }))
        ]
        )
    );
  }
}
