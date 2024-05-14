
import 'package:flutter/material.dart';
import 'package:uyishi_14_05/uyishi/homePagee.dart';


void main(List<String> args) {
  runApp(MyApp()); 
}
class MyApp extends StatelessWidget{
  MyApp({super.key});

@override
Widget build(BuildContext context){
  return MaterialApp(
    
    debugShowCheckedModeBanner:false,
    home: HomePage(),
    

  );
}
}
