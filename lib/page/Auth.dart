import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stream_games/domain/user.dart';
import 'package:stream_games/services/auth.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  String _password;
  bool _showLogin = true;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                    data: IconThemeData(color: Colors.white), child: icon),
              )),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(
                    Icon(Icons.email), "Email", _emailController, false)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(
                    Icon(Icons.lock), "Password", _passwordController, true)),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: _button(label, func)))
          ],
        ),
      );
    }

    void _loginButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      User user = await _authService.signInWithEmailAndPassword(
          _email.trim(), _password.trim());
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;
      User user = await _authService.registerWithEmailAndPassword(
          _email.trim(), _password.trim());
    }
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/logo.png'),
            (_showLogin
                ? Column(
              children: <Widget>[
                _form('Login!', _loginButtonAction),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                      child: Text("Not registered yet? Register!",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white)),
                      onTap: () {
                        setState(() {
                          _showLogin = false;
                        });
                      }),
                ),
                RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    highlightColor: Theme.of(context).primaryColor,
                    color: Colors.white,
                    child: Text("Forgot password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20)),
                    onPressed: () async {
                      String _email = _emailController.text;
                      if (_email == "") {
                        Fluttertoast.showToast(
                            msg: "Insert email",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        auth.sendPasswordResetEmail(email: _email);
                        Fluttertoast.showToast(
                            msg: "Change password letter was sent to " +
                                _email,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    })
              ],
            )
                : Column(
              children: <Widget>[
                _form('Register!', _registerButtonAction), //не забудь
                Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                      child: Text("Already registered? Login!",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white)),
                      onTap: () {
                        setState(() {
                          _showLogin = true;
                        });
                      }),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}