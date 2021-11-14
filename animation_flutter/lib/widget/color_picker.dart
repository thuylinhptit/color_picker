import 'package:animation_flutter/widget/alpha_picker.dart';
import 'package:animation_flutter/widget/hex_picker.dart';
import 'package:animation_flutter/picker/wheel_picker.dart';
import 'package:flutter/material.dart';
enum PickerOrientation {
  inherit,
  portrait,
  landscape,
}

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    required this.onChanged,
    this.color = Colors.blue,
    this.pickerOrientation = PickerOrientation.inherit,
    Key? key,
  }) : super(key: key);

  final ValueChanged<Color> onChanged;
  final Color color;

  final PickerOrientation pickerOrientation;

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  _ColorPickerState();

  // Color
  late int _alpha;
  late Color _color;
  late HSVColor _hSVColor;

  void _alphaOnChanged(int value) {
    _alpha = value;
    _color = _color.withAlpha(_alpha);
    widget.onChanged(_color);
  }

  void _colorOnChanged(Color value) {
    _color = value;
    _hSVColor = HSVColor.fromColor(value);
    widget.onChanged(value);
  }

  void _hSVColorOnChanged(HSVColor value) {
    _color = value.toColor();
    _hSVColor = value;
    widget.onChanged(value.toColor());
  }


  @override
  void initState() {
    super.initState();

    _color = widget.color;
    _alpha = _color.alpha;
    _hSVColor = HSVColor.fromColor(_color);
  }


  Widget _buildHead() {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black26),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                color: _color,
              ),
            ),
          ),

          const SizedBox(width: 22),
          Expanded(
            child: HexPicker(
              color: _color,
              onChanged: (Color value) => super.setState(
                    () => _colorOnChanged(value),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget _buildBody() {
    return SizedBox(
      child: WheelPicker(
        color: _hSVColor,
        onChanged: (HSVColor value) => super.setState(
              () => _hSVColorOnChanged(value),
        ),
      ),
    );
  }

  Widget _buildAlphaPicker() {
    return AlphaPicker(
      alpha: _alpha,
      onChanged: (int value) => super.setState(
            () => _alphaOnChanged(value),
      ),
    );
  }

  Orientation _getOrientation(PickerOrientation pickerOrientation) {
    switch (pickerOrientation) {
      case PickerOrientation.inherit:
        return MediaQuery.of(context).orientation;
      case PickerOrientation.portrait:
        return Orientation.portrait;
      case PickerOrientation.landscape:
        return Orientation.landscape;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = _getOrientation(widget.pickerOrientation);

    switch (orientation) {
      case Orientation.portrait:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            _buildHead(),
            SizedBox(height: 30,),
            _buildBody(),
            SizedBox(height: 30,),
            _buildAlphaPicker(),
          ],
        );

      case Orientation.landscape:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildHead(),
                  _buildAlphaPicker(),
                ],
              ),
            ),
            Expanded(
              child: _buildBody(),
            )
          ],
        );
    }
  }
}

