import 'package:flutter/material.dart';
import 'package:gif_searcher/ui/gif_page.dart';
import 'package:gif_searcher/ui/home_page.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.white),
  ));
}
