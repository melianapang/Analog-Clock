import 'package:analog_clock/pages/page_bar_chart.dart';
import 'package:analog_clock/pages/page_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analog Clock',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        "/": (context) => HomePage(),
      },
    );
  }
}
