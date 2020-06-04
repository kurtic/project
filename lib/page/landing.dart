import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_games/domain/user.dart';
import 'package:stream_games/page/Auth.dart';
import 'package:stream_games/page/page_main.dart';

class LandingPage extends StatelessWidget{
  const LandingPage({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user= Provider.of(context);
    final bool isLogedIn= user != null;
    return isLogedIn ? MainPage(): AuthorizationPage();

  }
}