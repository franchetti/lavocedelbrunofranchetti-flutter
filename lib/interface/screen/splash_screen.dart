import 'package:app/assets.dart';
import 'package:app/bloc/currentstate_bloc.dart';
import 'package:app/interface/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    currentStateBloc.initialize();
    Future.delayed(Duration(seconds: 8)).then((onTimer) => Navigator.of(context).pushReplacementNamed(HomeScreen.route));

    return Scaffold(
      // backgroundColor: Colors.orange,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(child: Image(image: Theme.of(context).brightness == Brightness.dark ? Images.icExtendedDark : Images.icExtended)),
    );
  }
}
