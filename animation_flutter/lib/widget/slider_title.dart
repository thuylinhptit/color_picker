
import 'package:flutter/material.dart';

class SliderTitle extends StatelessWidget{
  final String title;
  final String text;

  SliderTitle( this.title, this.text );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
       children: [
         Text( title, style: TextStyle( color: Colors.grey, fontSize: 20, ),),
         Spacer(),
         Text( text, style: TextStyle( color: Colors.grey, fontSize: 20),)
       ],
      ),
    );
  }

}