

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget  {
  var title;
  CustomAppBar({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }
}
