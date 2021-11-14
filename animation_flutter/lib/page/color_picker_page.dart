import 'package:animation_flutter/widget/color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Container(

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 2.0,
              ),
              child: ColorPicker(
                color: Colors.blue,
                onChanged: (value) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
