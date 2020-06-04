import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_games/model/repository.dart';
import 'package:stream_games/page/landing.dart';

import 'package:stream_games/services/auth.dart';
import 'package:stream_games/themes.dart';

import 'domain/user.dart';
import 'utils/APIget.dart';
import 'model/repository.dart';
void main() => runApp(FlutterGames());

class FlutterGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().currentUser,
        child:MaterialApp(
          title: 'Flutter Games',
          theme: defaultTheme,
          home: LandingPage(),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}
