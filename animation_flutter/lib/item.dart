import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget{
  String text;
  ItemView( this.text );
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey
            ),
            height: 1,
            width: width-20,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text, style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.grey
            ),
            height: 1,
            width: width-20,
          ),
        ],
      ),
    );
  }

}