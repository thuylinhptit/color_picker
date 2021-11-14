import 'package:animation_flutter/widget/alpha_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleColorPicker extends StatefulWidget{
  @override
  _CircleColorPicker createState() => _CircleColorPicker();

}
class _CircleColorPicker extends State<CircleColorPicker>{
  int value = 0;
  void onChanged(int value) => this.value = value;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Divider(),
                AlphaPicker(
                  alpha: value,
                  onChanged: (value) => super.setState(
                        () => onChanged(value),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}