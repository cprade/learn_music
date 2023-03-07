import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_music/controller/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
              titleTextStyle:
                  GoogleFonts.signika(color: Colors.black, fontSize: 18),
              iconTheme: const IconThemeData(color: Colors.black))),
      darkTheme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
