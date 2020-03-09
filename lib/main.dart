import 'package:custom_slider/common_textstyles.dart';
import 'package:custom_slider/slider/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider<SliderValueNotifier>(
        create: (context) => SliderValueNotifier(30),
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "The Current Value Is:",
              style: CommonTextStyles.getBoldTextStyleLight(context).copyWith(
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "${Provider.of<SliderValueNotifier>(context, listen: true).currentValue.round()}",
                style: CommonTextStyles.getBlackTextStyleLight(context).copyWith(
                  fontSize: 98,
                ),
              ),
            ),
            CustomSlider(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
