
import 'package:flutter/material.dart';
import '../route/routes_name.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: mediumTS(appBarColor, fontSize: 24)),
      leading: GestureDetector(
          onTap:(){
            Navigator.pushReplacementNamed(context, RoutesName.home,);
          },child: const Icon(Icons.arrow_back,color: Colors.black,)),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
