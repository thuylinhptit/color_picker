

import 'package:animation_flutter/item.dart';
import 'package:animation_flutter/page/color_picker_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePage createState() => _MyHomePage();

}

class _MyHomePage extends State<MyHomePage>{
  bool isDark = false;
  ThemeData get theme => isDark ? themeDark : themeLight;
  ThemeData themeLight =
  ThemeData(brightness: Brightness.light, platform: TargetPlatform.iOS);
  ThemeData themeDark =
  ThemeData(brightness: Brightness.dark, platform: TargetPlatform.iOS);
  void setTheme() => super.setState(() => isDark = !isDark);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Animation Flutter", style: TextStyle( color: Colors.white, fontSize: 20),),
        ),
        body: ListView(
          children: [
            Container(
              height: 20,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(onPressed: (){
                setTheme();
              }, icon: const Icon(Icons.light)),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              child: ItemView("Circle Color Picker"),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ColorPickerPage())),
            ),
          ],
        )
      ),
    );
  }

}
