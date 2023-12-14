// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
const AppTabs({super.key, required this.color, required this.text});

@override
Widget build(BuildContext context){
  return Container(
            width: 100,
            height: 40,
            // ignore: sort_child_properties_last
            child: Text(
              text, style: const TextStyle(color:Colors.white, fontSize: 20),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // ignore: unnecessary_this
              color:this.color,
              boxShadow: [
                BoxShadow(
                  color:Colors.grey.withOpacity(0.3),
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
          );
}





}