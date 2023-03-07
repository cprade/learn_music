import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChoice {
  String label;
  IconData iconData;
  Widget page;

  Icon get icon=> Icon(iconData);
  BottomNavigationBarItem get item => BottomNavigationBarItem(icon: icon, label: label);
  Text get titleForAppBar => Text(label, style: GoogleFonts.signika(fontSize: 30));

  BarChoice({required this.label, required this.iconData, required this.page});


}